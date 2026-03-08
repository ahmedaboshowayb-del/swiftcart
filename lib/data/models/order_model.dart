import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/order_entity.dart';

class OrderModel {
  const OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.deliveryAddress,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.paymentMethod,
    required this.createdAt,
    required this.itemsData,
    this.estimatedDelivery,
    this.promoCode,
  });

  final String   id;
  final String   userId;
  final String   status;
  final double   subtotal;
  final double   deliveryFee;
  final double   total;
  final String   deliveryAddress;
  final double   deliveryLat;
  final double   deliveryLng;
  final String   paymentMethod;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;
  final String?  promoCode;
  final List<Map<String, dynamic>> itemsData;

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};

    debugPrint('🔄 Parsing order doc: ${doc.id}');
    debugPrint('   fields: ${d.keys.toList()}');

    List<Map<String, dynamic>> items = [];
    try {
      final rawItems = d['items'];
      if (rawItems is List) {
        items = rawItems
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      }
    } catch (e) {
      debugPrint('⚠️ Could not parse items: $e');
    }

    return OrderModel(
      id:              doc.id,
      userId:          (d['user_id']       as String?)  ?? '',
      status:          (d['status']        as String?)  ?? 'preparing',
      subtotal:        ((d['subtotal']     as num?)     ?? 0).toDouble(),
      deliveryFee:     ((d['delivery_fee'] as num?)     ?? 0).toDouble(),
      total:           ((d['total']        as num?)     ?? 0).toDouble(),
      deliveryAddress: (d['delivery_address'] as String?) ?? '',
      deliveryLat:     ((d['delivery_lat'] as num?)     ?? 0).toDouble(),
      deliveryLng:     ((d['delivery_lng'] as num?)     ?? 0).toDouble(),
      paymentMethod:   (d['payment_method'] as String?) ?? '',
      promoCode:       d['promo_code']     as String?,
      createdAt:       _parseDate(d['created_at']),
      estimatedDelivery: _parseDateNullable(d['estimated_delivery']),
      itemsData:       items,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      try { return DateTime.parse(value); } catch (_) {}
    }
    return DateTime.now();
  }

  static DateTime? _parseDateNullable(dynamic value) {
    if (value == null) return null;
    return _parseDate(value);
  }

  OrderEntity toEntity(List<CartItemEntity> resolvedItems) => OrderEntity(
        id:               id,
        userId:           userId,
        items:            resolvedItems,
        status:           OrderStatus.fromString(status),
        subtotal:         subtotal,
        deliveryFee:      deliveryFee,
        total:            total,
        deliveryAddress:  deliveryAddress,
        deliveryLat:      deliveryLat,
        deliveryLng:      deliveryLng,
        paymentMethod:    paymentMethod,
        promoCode:        promoCode,
        createdAt:        createdAt,
        estimatedDelivery: estimatedDelivery,
      );
}