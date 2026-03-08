import 'package:dartz/dartz.dart';
import '../entities/order_entity.dart';
import '../entities/cart_item_entity.dart';
import '../../core/utils/failure.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getUserOrders(String userId);
  Future<Either<Failure, OrderEntity>>       getOrderById(String orderId);
  Future<Either<Failure, OrderEntity>>       placeOrder({
    required String             userId,
    required List<CartItemEntity> items,
    required String             deliveryAddress,
    required double             deliveryLat,
    required double             deliveryLng,
    required String             paymentMethod,
    required double             subtotal,
    required double             deliveryFee,
    String?                     promoCode,
  });
  Stream<OrderEntity> watchOrderStatus(String orderId);
}