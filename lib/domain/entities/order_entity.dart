import 'package:equatable/equatable.dart';
import 'cart_item_entity.dart';

enum OrderStatus {
  preparing,
  onTheWay,
  delivered,
  cancelled;

  static OrderStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'on_the_way':
      case 'ontheway':
      case 'on the way':
        return OrderStatus.onTheWay;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
      case 'canceled':
        return OrderStatus.cancelled;
      case 'preparing':
      default:
        return OrderStatus.preparing;
    }
  }

  String get label {
    switch (this) {
      case OrderStatus.preparing:  return 'Preparing';
      case OrderStatus.onTheWay:   return 'On the Way';
      case OrderStatus.delivered:  return 'Delivered';
      case OrderStatus.cancelled:  return 'Cancelled';
    }
  }

  String get firestoreValue {
    switch (this) {
      case OrderStatus.preparing:  return 'preparing';
      case OrderStatus.onTheWay:   return 'on_the_way';
      case OrderStatus.delivered:  return 'delivered';
      case OrderStatus.cancelled:  return 'cancelled';
    }
  }

  bool get isActive    => this == preparing || this == onTheWay;
  bool get isCompleted => this == delivered;
  bool get isCancelled => this == cancelled;
}

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.status,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.deliveryAddress,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.paymentMethod,
    required this.createdAt,
    this.estimatedDelivery,
    this.promoCode,    
  });

  final String            id;
  final String            userId;
  final List<CartItemEntity> items;
  final OrderStatus       status;
  final double            subtotal;
  final double            deliveryFee;
  final double            total;
  final String            deliveryAddress;
  final double            deliveryLat;
  final double            deliveryLng;
  final String            paymentMethod;
  final DateTime          createdAt;
  final DateTime?         estimatedDelivery;
  final String?           promoCode;         

  @override
  List<Object?> get props => [
        id, userId, status, total, createdAt, promoCode,
      ];
}