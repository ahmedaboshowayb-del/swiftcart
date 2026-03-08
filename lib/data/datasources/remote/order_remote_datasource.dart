import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/order_model.dart';
import '../../../core/constants/app_constants.dart';

part 'order_remote_datasource.g.dart';

@riverpod
OrderRemoteDataSource orderRemoteDataSource(OrderRemoteDataSourceRef ref) =>
    OrderRemoteDataSource(FirebaseFirestore.instance);

class OrderRemoteDataSource {
  OrderRemoteDataSource(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(AppConstants.ordersCollection);

  Future<List<OrderModel>> getUserOrders(String userId) async {
    debugPrint('🔍 Querying orders for userId: $userId');

    try {
      final snap = await _col
          .where('user_id', isEqualTo: userId)
          .get();

      debugPrint('📦 Raw Firestore docs returned: ${snap.docs.length}');
      for (final doc in snap.docs) {
        debugPrint('   doc id: ${doc.id}, data: ${doc.data()}');
      }

      final orders = snap.docs
          .map((doc) {
            try {
              return OrderModel.fromFirestore(doc);
            } catch (e) {
              debugPrint('❌ Failed to parse order ${doc.id}: $e');
              return null;
            }
          })
          .whereType<OrderModel>()
          .toList();

      orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      debugPrint('✅ Parsed ${orders.length} orders successfully');
      return orders;
    } catch (e) {
      debugPrint('❌ getUserOrders Firestore error: $e');
      rethrow;
    }
  }

  Future<OrderModel> getOrderById(String orderId) async {
    final doc = await _col.doc(orderId).get();
    if (!doc.exists) throw Exception('Order $orderId not found');
    return OrderModel.fromFirestore(doc);
  }

  Future<OrderModel> placeOrder(Map<String, dynamic> data) async {
    final ref = await _col.add(data);
    final doc = await ref.get();
    return OrderModel.fromFirestore(doc);
  }

  Stream<OrderModel> watchOrderStatus(String orderId) {
    return _col.doc(orderId).snapshots().map(OrderModel.fromFirestore);
  }
}