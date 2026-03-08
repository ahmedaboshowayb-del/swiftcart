import 'package:dartz/dartz.dart';
import '../../repositories/cart_repository.dart';
import '../../../core/utils/failure.dart';

class UpdateQuantityParams {
  const UpdateQuantityParams({
    required this.productId,
    required this.quantity,
  });
  final String productId;
  final int    quantity; 
}

class UpdateQuantityUseCase {
  const UpdateQuantityUseCase(this._repo);
  final CartRepository _repo;


  Future<Either<Failure, void>> call(UpdateQuantityParams p) =>
      _repo.updateQuantity(p.productId, p.quantity);
}