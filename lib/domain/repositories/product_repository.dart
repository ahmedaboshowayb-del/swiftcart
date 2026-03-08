import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';
import '../../core/utils/failure.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? sortBy,
    int page  = 1,
    int limit = 20,
  });

  Future<Either<Failure, ProductEntity>>       getProductById(String id);
  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts();
  Future<Either<Failure, List<ProductEntity>>> getNewArrivals();
  Future<Either<Failure, List<ProductEntity>>> getSimilarProducts(String id, String categoryId);
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
}