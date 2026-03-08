import 'package:dartz/dartz.dart';
import '../../entities/cart_item_entity.dart';
import '../../entities/order_entity.dart';
import '../../repositories/order_repository.dart';
import '../../repositories/cart_repository.dart';
import '../../../core/utils/failure.dart';

class PlaceOrderParams {
  const PlaceOrderParams({
    required this.userId,
    required this.items,
    required this.deliveryAddress,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    this.promoCode,
  });
  final String             userId;
  final List<CartItemEntity> items;
  final String             deliveryAddress;
  final double             deliveryLat;
  final double             deliveryLng;
  final String             paymentMethod;
  final double             subtotal;
  final double             deliveryFee;
  final String?            promoCode;
}

class PlaceOrderUseCase {
  const PlaceOrderUseCase(this._orderRepo, this._cartRepo);
  final OrderRepository _orderRepo;
  final CartRepository  _cartRepo;

  Future<Either<Failure, OrderEntity>> call(PlaceOrderParams p) async {
    final result = await _orderRepo.placeOrder(
      userId:          p.userId,
      items:           p.items,
      deliveryAddress: p.deliveryAddress,
      deliveryLat:     p.deliveryLat,
      deliveryLng:     p.deliveryLng,
      paymentMethod:   p.paymentMethod,
      subtotal:        p.subtotal,
      deliveryFee:     p.deliveryFee,
      promoCode:       p.promoCode,
    );

    if (result.isRight()) await _cartRepo.clearCart();

    return result;
  }
}