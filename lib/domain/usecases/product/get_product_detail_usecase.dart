import 'package:dartz/dartz.dart';
import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';
import '../../../core/utils/failure.dart';

class GetProductDetailUseCase {
  const GetProductDetailUseCase(this._repo);
  final ProductRepository _repo;

  Future<Either<Failure, ProductEntity>> call(String productId) =>
      _repo.getProductById(productId);
}