import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/product_entity.dart';
import '../../data/repositories/product_repository_impl.dart';

part 'product_provider.g.dart';

@riverpod
Future<ProductEntity> productDetail(ProductDetailRef ref, String id) async {
  final result = await ref.watch(productRepositoryProvider).getProductById(id);
  return result.fold(
    (f) => throw Exception(f.userMessage),
    (p) => p,
  );
}

@riverpod
Future<List<ProductEntity>> similarProducts(
    SimilarProductsRef ref, String id, String categoryId) async {
  final result = await ref
      .watch(productRepositoryProvider)
      .getSimilarProducts(id, categoryId);
  return result.fold(
    (f) => throw Exception(f.userMessage),
    (p) => p,
  );
}

@riverpod
class ProductImageIndex extends _$ProductImageIndex {
  @override
  int build() => 0;

  void setIndex(int i) => state = i;
}