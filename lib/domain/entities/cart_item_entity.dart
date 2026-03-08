import 'package:equatable/equatable.dart';
import 'product_entity.dart';

class CartItemEntity extends Equatable {
  const CartItemEntity({
    required this.product,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  final ProductEntity product;
  final int           quantity;
  final String?       selectedSize;
  final String?       selectedColor;

  double get itemTotal => product.effectivePrice * quantity;

  CartItemEntity copyWith({
    ProductEntity? product,
    int?           quantity,
    String?        selectedSize,
    String?        selectedColor,
  }) =>
      CartItemEntity(
        product:       product       ?? this.product,
        quantity:      quantity      ?? this.quantity,
        selectedSize:  selectedSize  ?? this.selectedSize,
        selectedColor: selectedColor ?? this.selectedColor,
      );

  @override
  List<Object?> get props =>
      [product.id, quantity, selectedSize, selectedColor];
}