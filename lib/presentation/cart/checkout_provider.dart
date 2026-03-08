import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/orders/place_order_usecase.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/cart_repository_impl.dart';
import 'cart_provider.dart';

part 'checkout_provider.freezed.dart';
part 'checkout_provider.g.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(AppConstants.paymentCash) String paymentMethod,
    @Default('') String address,
    @Default(0.0) double deliveryLat,
    @Default(0.0) double deliveryLng,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    OrderEntity?  placedOrder,
    String?       errorMessage,
  }) = _CheckoutState;
}

@riverpod
class CheckoutNotifier extends _$CheckoutNotifier {
  @override
  CheckoutState build() => const CheckoutState();

  void setPaymentMethod(String method) =>
      state = state.copyWith(paymentMethod: method, errorMessage: null);

  void setAddress(String address, double lat, double lng) =>
      state = state.copyWith(
        address: address,
        deliveryLat: lat,
        deliveryLng: lng,
        errorMessage: null,
      );

  Future<void> placeOrder() async {
    if (state.address.isEmpty) {
      state = state.copyWith(errorMessage: 'Please select a delivery address');
      return;
    }

    final items = ref.read(cartItemsProvider).valueOrNull ?? [];
    if (items.isEmpty) {
      state = state.copyWith(errorMessage: 'Your cart is empty');
      return;
    }

    final user = await ref.read(authRepositoryProvider).getCurrentUser();
    if (user == null) {
      state = state.copyWith(errorMessage: 'Please sign in to place an order');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    final useCase = PlaceOrderUseCase(
      ref.read(orderRepositoryProvider),
      ref.read(cartRepositoryProvider),
    );

    final result = await useCase(PlaceOrderParams(
      userId:          user.id,
      items:           items,
      deliveryAddress: state.address,
      deliveryLat:     state.deliveryLat,
      deliveryLng:     state.deliveryLng,
      paymentMethod:   state.paymentMethod,
      subtotal:        ref.read(cartSubtotalProvider),
      deliveryFee:     ref.read(deliveryFeeProvider),
    ));

    state = result.fold(
      (f) => state.copyWith(isLoading: false, errorMessage: f.userMessage),
      (order) => state.copyWith(
          isLoading: false, isSuccess: true, placedOrder: order),
    );
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}