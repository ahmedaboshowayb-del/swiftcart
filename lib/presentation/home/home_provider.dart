import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';

part 'home_provider.g.dart';

@riverpod
Future<List<ProductEntity>> featuredProducts(FeaturedProductsRef ref) async {
  final res = await ref.watch(productRepositoryProvider).getFeaturedProducts();
  return res.fold(
    (f) {
      debugPrint('❌ featuredProducts error: ${f.message}');  
      throw Exception(f.userMessage);
    },
    (p) {
      debugPrint('✅ featuredProducts loaded: ${p.length} items'); 
      return p;
    },
  );
}

@riverpod
Future<List<ProductEntity>> newArrivals(NewArrivalsRef ref) async {
  final res = await ref.watch(productRepositoryProvider).getNewArrivals();
  return res.fold(
    (f) {
      debugPrint('❌ newArrivals error: ${f.message}'); 
      throw Exception(f.userMessage);
    },
    (p) {
      debugPrint('✅ newArrivals loaded: ${p.length} items'); 
      return p;
    },
  );
}

@riverpod
Future<List<CategoryEntity>> homeCategories(HomeCategoriesRef ref) async {
  final res = await ref.watch(categoryRepositoryProvider).getCategories();
  return res.fold(
    (f) {
      debugPrint('❌ homeCategories error: ${f.message}'); 
      throw Exception(f.userMessage);
    },
    (c) {
      debugPrint('✅ homeCategories loaded: ${c.length} items');
      return c;
    },
  );
}