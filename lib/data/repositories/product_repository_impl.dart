import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../core/utils/failure.dart';
import '../datasources/remote/product_remote_datasource.dart';

part 'product_repository_impl.g.dart';

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) =>
    ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider));

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._remote);
  final ProductRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId, String? searchQuery,
    double? minPrice, double? maxPrice, double? minRating,
    String? sortBy, int page = 1, int limit = 20,
  }) =>
      _guard(() async {
        final models = await _remote.getProducts(
          categoryId: categoryId, minPrice: minPrice,
          maxPrice: maxPrice, minRating: minRating,
          sortBy: sortBy, limit: limit,
        );
        return models.map((m) => m.toEntity()).toList();
      });

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) =>
      _guard(() async => (await _remote.getProductById(id)).toEntity());

  @override
  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts() =>
      _guard(() async {
        final m = await _remote.getFeaturedProducts();
        return m.map((e) => e.toEntity()).toList();
      });

  @override
  Future<Either<Failure, List<ProductEntity>>> getNewArrivals() =>
      _guard(() async {
        final m = await _remote.getNewArrivals();
        return m.map((e) => e.toEntity()).toList();
      });

  @override
  Future<Either<Failure, List<ProductEntity>>> getSimilarProducts(String id, String catId) =>
      _guard(() async {
        final m = await _remote.getSimilarProducts(id, catId);
        return m.map((e) => e.toEntity()).toList();
      });

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) =>
      _guard(() async {
        final m = await _remote.searchProducts(query);
        return m.map((e) => e.toEntity()).toList();
      });

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Firebase error', code: e.code));
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}