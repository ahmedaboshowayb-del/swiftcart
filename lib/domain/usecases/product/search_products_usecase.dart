import 'package:dartz/dartz.dart';
import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';
import '../../../core/utils/failure.dart';

class SearchProductsUseCase {
  const SearchProductsUseCase(this._repo);
  final ProductRepository _repo;

  Future<Either<Failure, List<ProductEntity>>> call(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return Future.value(
        const Left(ValidationFailure('Search query cannot be empty')),
      );
    }
    return _repo.searchProducts(trimmed);
  }
}