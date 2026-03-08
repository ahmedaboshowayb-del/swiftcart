import 'package:dartz/dartz.dart';
import '../../repositories/cart_repository.dart';
import '../../../core/utils/failure.dart';

class RemoveFromCartUseCase {
  const RemoveFromCartUseCase(this._repo);
  final CartRepository _repo;

  Future<Either<Failure, void>> call(String productId) =>
      _repo.removeFromCart(productId);
}