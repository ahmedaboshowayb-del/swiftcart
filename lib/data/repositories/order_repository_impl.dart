import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/failure.dart';
import '../datasources/remote/order_remote_datasource.dart';
import '../models/cart_item_model.dart';

part 'order_repository_impl.g.dart';

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) =>
    OrderRepositoryImpl(ref.watch(orderRemoteDataSourceProvider));

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl(this._remote);
  final OrderRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders(
      String userId) =>
      _guard(() async {
        final models = await _remote.getUserOrders(userId);
        return models
            .map((m) => m.toEntity(_resolveItems(m.itemsData)))
            .toList();
      });

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(String orderId) =>
      _guard(() async {
        final m = await _remote.getOrderById(orderId);
        return m.toEntity(_resolveItems(m.itemsData));
      });

  @override
  Future<Either<Failure, OrderEntity>> placeOrder({
    required String userId,
    required List<CartItemEntity> items,
    required String deliveryAddress,
    required double deliveryLat,
    required double deliveryLng,
    required String paymentMethod,
    required double subtotal,
    required double deliveryFee,
    String? promoCode,
  }) =>
      _guard(() async {
        final total = subtotal + deliveryFee;
        final itemsData = items
            .map((i) => CartItemModel.fromEntity(i).toOrderMap())
            .toList();

        final data = {
          'user_id':          userId,
          'items':            itemsData,
          'status':           AppConstants.statusPreparing,
          'subtotal':         subtotal,
          'delivery_fee':     deliveryFee,
          'total':            total,
          'delivery_address': deliveryAddress,
          'delivery_lat':     deliveryLat,
          'delivery_lng':     deliveryLng,
          'payment_method':   paymentMethod,
          'promo_code':       promoCode,
          'created_at':       Timestamp.now(),
          'estimated_delivery': Timestamp.fromDate(
              DateTime.now().add(const Duration(minutes: 45))),
        };

        final model = await _remote.placeOrder(data);
        return model.toEntity(items); 
      });

  @override
  Stream<OrderEntity> watchOrderStatus(String orderId) =>
      _remote.watchOrderStatus(orderId).map(
            (m) => m.toEntity(_resolveItems(m.itemsData)),
          );

  List<CartItemEntity> _resolveItems(
      List<Map<String, dynamic>> rawItems) {
    return rawItems.map((raw) {
      final model = CartItemModel.fromMap({
        'productId':    raw['product_id']    ?? '',
        'productName':  raw['product_name']  ?? '',
        'price':        raw['original_price'] ?? raw['price'] ?? 0,
        'discountPrice': raw['price'] != raw['original_price']
            ? raw['price']
            : null,
        'imageUrl':     raw['image_url']     ?? '',
        'quantity':     raw['quantity']      ?? 1,
        'selectedSize': raw['selected_size'],
        'selectedColor': raw['selected_color'],
        'categoryId':   '',
        'categoryName': '',
        'brand':        '',
      });
      return model.toEntity();
    }).toList();
  }

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Firebase error', code: e.code));
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}