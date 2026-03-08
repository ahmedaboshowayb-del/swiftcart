import 'package:dartz/dartz.dart';
import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';
import '../../../core/utils/failure.dart';

class GetProductsParams {
  const GetProductsParams({
    this.categoryId,
    this.searchQuery,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.sortBy,
    this.page  = 1,
    this.limit = 20,
  });
  final String? categoryId;
  final String? searchQuery;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final String? sortBy;
  final int     page;
  final int     limit;
}

class GetProductsUseCase {
  const GetProductsUseCase(this._repo);
  final ProductRepository _repo;

  Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams p) =>
      _repo.getProducts(
        categoryId:  p.categoryId,
        searchQuery: p.searchQuery,
        minPrice:    p.minPrice,
        maxPrice:    p.maxPrice,
        minRating:   p.minRating,
        sortBy:      p.sortBy,
        page:        p.page,
        limit:       p.limit,
      );
}