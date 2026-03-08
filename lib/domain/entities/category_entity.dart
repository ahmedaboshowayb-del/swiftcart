import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
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

  bool get isTopLevel => parentId == null;

  @override
  List<Object?> get props => [id, name, parentId];
}