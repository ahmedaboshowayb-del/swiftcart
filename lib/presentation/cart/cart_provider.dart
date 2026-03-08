import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/cart/add_to_cart_usecase.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../core/constants/app_constants.dart';

part 'cart_provider.g.dart';

@riverpod
Stream<List<CartItemEntity>> cartItems(CartItemsRef ref) =>
    ref.watch(cartRepositoryProvider).watchCartItems();

@riverpod
int cartItemCount(CartItemCountRef ref) {
  final items = ref.watch(cartItemsProvider).valueOrNull ?? [];
  return items.fold(0, (sum, i) => sum + i.quantity);
}

@riverpod
double cartSubtotal(CartSubtotalRef ref) {
  final items = ref.watch(cartItemsProvider).valueOrNull ?? [];
  return items.fold(0.0, (sum, i) => sum + i.itemTotal);
}

@riverpod
double deliveryFee(DeliveryFeeRef ref) {
  final sub = ref.watch(cartSubtotalProvider);
  return sub >= AppConstants.freeDeliveryAbove ? 0 : AppConstants.deliveryFeeDefault;
}

@riverpod
double cartTotal(CartTotalRef ref) =>
    ref.watch(cartSubtotalProvider) + ref.watch(deliveryFeeProvider);

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> addToCart(ProductEntity product, {int quantity = 1}) async {
    state = const AsyncLoading();
    final uc = AddToCartUseCase(ref.read(cartRepositoryProvider));
    final res = await uc(CartItemEntity(product: product, quantity: quantity));
    state = res.fold(
      (f) => AsyncError(f.userMessage, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> remove(String productId) =>
      ref.read(cartRepositoryProvider).removeFromCart(productId);

  Future<void> updateQty(String productId, int qty) =>
      ref.read(cartRepositoryProvider).updateQuantity(productId, qty);

  Future<void> clear() =>
      ref.read(cartRepositoryProvider).clearCart();
}