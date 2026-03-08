import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();   

  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    double?         discountPrice,
    @Default([]) List<String> images,
    required String categoryId,
    @Default('') String categoryName,
    @Default('') String brand,
    @Default(0.0) double rating,
    @Default(0)   int reviewCount,
    @Default(0)   int stock,
    @Default([]) List<String> tags,
    @Default(false) bool isFeatured,
    @Default(false) bool isNew,
    @JsonKey(name: 'created_at', fromJson: _tsToDate, toJson: _dateToTs)
    required DateTime createdAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id:            doc.id,
      name:          d['name']           as String?  ?? '',
      description:   d['description']    as String?  ?? '',
      price:         (d['price'] as num?)?.toDouble()       ?? 0,
      discountPrice: (d['discount_price'] as num?)?.toDouble(),
      images:        List<String>.from(d['images'] as List? ?? []),
      categoryId:    d['category_id']    as String?  ?? '',
      categoryName:  d['category_name']  as String?  ?? '',
      brand:         d['brand']          as String?  ?? '',
      rating:        (d['rating'] as num?)?.toDouble()       ?? 0,
      reviewCount:   d['review_count']   as int?     ?? 0,
      stock:         d['stock']          as int?     ?? 0,
      tags:          List<String>.from(d['tags'] as List? ?? []),
      isFeatured:    d['is_featured']    as bool?    ?? false,
      isNew:         d['is_new']         as bool?    ?? false,
      createdAt:     (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'name':           name,
    'description':    description,
    'price':          price,
    'discount_price': discountPrice,
    'images':         images,
    'category_id':    categoryId,
    'category_name':  categoryName,
    'brand':          brand,
    'rating':         rating,
    'review_count':   reviewCount,
    'stock':          stock,
    'tags':           tags,
    'is_featured':    isFeatured,
    'is_new':         isNew,
    'created_at':     Timestamp.fromDate(createdAt),
  };

  ProductEntity toEntity() => ProductEntity(
    id:            id,
    name:          name,
    description:   description,
    price:         price,
    discountPrice: discountPrice,
    images:        images,
    categoryId:    categoryId,
    categoryName:  categoryName,
    brand:         brand,
    rating:        rating,
    reviewCount:   reviewCount,
    stock:         stock,
    tags:          tags,
    isFeatured:    isFeatured,
    isNew:         isNew,
    createdAt:     createdAt,
  );
}

DateTime _tsToDate(dynamic v) {
  if (v is Timestamp) return v.toDate();
  if (v is String)    return DateTime.parse(v);
  return DateTime.now();
}
String _dateToTs(DateTime d) => d.toIso8601String();