import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.images,
    required this.categoryId,
    required this.categoryName,
    required this.brand,
    required this.rating,
    required this.reviewCount,
    required this.stock,
    required this.tags,
    required this.isFeatured,
    required this.isNew,
    required this.createdAt,
  });

  final String  id;
  final String  name;
  final String  description;
  final double  price;
  final double? discountPrice;
  final List<String> images;
  final String  categoryId;
  final String  categoryName;
  final String  brand;
  final double  rating;
  final int     reviewCount;
  final int     stock;
  final List<String> tags;
  final bool    isFeatured;
  final bool    isNew;
  final DateTime createdAt;

  bool   get isInStock          => stock > 0;
  bool   get hasDiscount        => discountPrice != null && discountPrice! < price;
  double get effectivePrice     => discountPrice ?? price;
  double get discountPercentage =>
      hasDiscount ? ((price - discountPrice!) / price * 100).roundToDouble() : 0;
  String get primaryImage       => images.isNotEmpty ? images.first : '';

  ProductEntity copyWith({
    String?       id,
    String?       name,
    String?       description,
    double?       price,
    double?       discountPrice,
    List<String>? images,
    String?       categoryId,
    String?       categoryName,
    String?       brand,
    double?       rating,
    int?          reviewCount,
    int?          stock,
    List<String>? tags,
    bool?         isFeatured,
    bool?         isNew,
    DateTime?     createdAt,
  }) =>
      ProductEntity(
        id:            id            ?? this.id,
        name:          name          ?? this.name,
        description:   description   ?? this.description,
        price:         price         ?? this.price,
        discountPrice: discountPrice ?? this.discountPrice,
        images:        images        ?? this.images,
        categoryId:    categoryId    ?? this.categoryId,
        categoryName:  categoryName  ?? this.categoryName,
        brand:         brand         ?? this.brand,
        rating:        rating        ?? this.rating,
        reviewCount:   reviewCount   ?? this.reviewCount,
        stock:         stock         ?? this.stock,
        tags:          tags          ?? this.tags,
        isFeatured:    isFeatured    ?? this.isFeatured,
        isNew:         isNew         ?? this.isNew,
        createdAt:     createdAt     ?? this.createdAt,
      );

  @override
  List<Object?> get props =>
      [id, name, price, discountPrice, stock, rating, reviewCount];
}