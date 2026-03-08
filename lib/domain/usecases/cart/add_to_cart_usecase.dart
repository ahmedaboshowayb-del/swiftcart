import 'package:dartz/dartz.dart';
import '../../entities/cart_item_entity.dart';
import '../../repositories/cart_repository.dart';
import '../../../core/utils/failure.dart';

class AddToCartUseCase {
  const AddToCartUseCase(this._repo);
  final CartRepository _repo;

  Future<Either<Failure, void>> call(CartItemEntity item) =>
      _repo.addToCart(item);
}