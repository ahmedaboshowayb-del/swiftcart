import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/order_entity.dart';
import '../../data/repositories/order_repository_impl.dart';

part 'orders_provider.g.dart';

@riverpod
Future<List<OrderEntity>> userOrders(UserOrdersRef ref) async {
  final user = FirebaseAuth.instance.currentUser;

  debugPrint('👤 Current user UID: ${user?.uid}');
  debugPrint('👤 Current user email: ${user?.email}');

  if (user == null) {
    debugPrint('❌ No user logged in — returning empty orders');
    return [];
  }

  final result = await ref
      .watch(orderRepositoryProvider)
      .getUserOrders(user.uid);

  return result.fold(
    (failure) {
      debugPrint('❌ Orders error: ${failure.message}');  
      throw Exception(failure.userMessage);
    },
    (orders) {
      debugPrint('✅ Orders loaded: ${orders.length} orders');
      for (final o in orders) {
        debugPrint('   📦 Order: ${o.id} — ${o.status}');
      }
      return orders;
    },
  );
}

@riverpod
Future<OrderEntity> orderDetail(OrderDetailRef ref, String orderId) async {
  final result = await ref
      .watch(orderRepositoryProvider)
      .getOrderById(orderId);

  return result.fold(
    (f) {
      debugPrint('❌ Order detail error: ${f.message}');
      throw Exception(f.userMessage);
    },
    (order) => order,
  );
}

@riverpod
Stream<OrderEntity> orderStatus(OrderStatusRef ref, String orderId) {
  return ref
      .watch(orderRepositoryProvider)
      .watchOrderStatus(orderId);
}