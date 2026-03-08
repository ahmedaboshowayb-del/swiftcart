import 'package:dartz/dartz.dart';
import '../entities/cart_item_entity.dart';
import '../../core/utils/failure.dart';

abstract interface class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> getCartItems();
  Future<Either<Failure, void>>                 addToCart(CartItemEntity item);
  Future<Either<Failure, void>>                 removeFromCart(String productId);
  Future<Either<Failure, void>>                 updateQuantity(String productId, int quantity);
  Future<Either<Failure, void>>                 clearCart();
  Stream<List<CartItemEntity>>                  watchCartItems();
}