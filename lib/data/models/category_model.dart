import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.icon,
    required this.imageUrl,
    required this.productCount,
    required this.isActive,
    this.parentId,
  });

  final String  id;
  final String  name;
  final String  nameAr;
  final String  icon;
  final String  imageUrl;
  final int     productCount;
  final bool    isActive;
  final String? parentId;

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      id:           doc.id,
      name:         d['name']          as String?  ?? '',
      nameAr:       d['name_ar']       as String?  ?? '',
      icon:         d['icon']          as String?  ?? '🛍️',
      imageUrl:     d['image_url']     as String?  ?? '',
      productCount: d['product_count'] as int?     ?? 0,
      isActive:     d['is_active']     as bool?    ?? true,
      parentId:     d['parent_id']     as String?,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name':          name,
        'name_ar':       nameAr,
        'icon':          icon,
        'image_url':     imageUrl,
        'product_count': productCount,
        'is_active':     isActive,
        'parent_id':     parentId,
      };

  CategoryEntity toEntity() => CategoryEntity(
        id:           id,
        name:         name,
        nameAr:       nameAr,
        icon:         icon,
        imageUrl:     imageUrl,
        productCount: productCount,
        isActive:     isActive,
        parentId:     parentId,
      );
}