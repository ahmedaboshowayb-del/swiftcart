import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../core/utils/failure.dart';
import '../datasources/local/cart_local_datasource.dart';

part 'cart_repository_impl.g.dart';

@riverpod
CartRepository cartRepository(CartRepositoryRef ref) =>
    CartRepositoryImpl(ref.watch(cartLocalDataSourceProvider));

class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl(this._local);
  final CartLocalDataSource _local;

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCartItems() async {
    try {
      final items = await _local.getItems();
      return Right(items.map(_hiveToEntity).toList());
    } catch (e) {
      return Left(CacheFailure('Failed to load cart: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart(CartItemEntity item) async {
    try {
      await _local.save(HiveCartItem(
        productId:     item.product.id,
        name:          item.product.name,
        price:         item.product.price,
        discountPrice: item.product.discountPrice,
        imageUrl:      item.product.primaryImage,
        quantity:      item.quantity,
        selectedSize:  item.selectedSize,
        selectedColor: item.selectedColor,
      ));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to add to cart: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(String productId) async {
    try { await _local.remove(productId); return const Right(null); }
    catch (e) { return Left(CacheFailure('$e')); }
  }

  @override
  Future<Either<Failure, void>> updateQuantity(String productId, int quantity) async {
    try {
      if (quantity <= 0) { await _local.remove(productId); }
      else               { await _local.updateQty(productId, quantity); }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('$e'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try { await _local.clear(); return const Right(null); }
    catch (e) { return Left(CacheFailure('$e')); }
  }

  @override
  Stream<List<CartItemEntity>> watchCartItems() =>
      _local.watch().map((items) => items.map(_hiveToEntity).toList());

  CartItemEntity _hiveToEntity(HiveCartItem h) => CartItemEntity(
    product: ProductEntity(
      id:            h.productId,
      name:          h.name,
      description:   '',
      price:         h.price,
      discountPrice: h.discountPrice,
      images:        [h.imageUrl],
      categoryId:    '',
      categoryName:  '',
      brand:         '',
      rating:        0,
      reviewCount:   0,
      stock:         999,   
      tags:          [],
      isFeatured:    false,
      isNew:         false,
      createdAt:     DateTime.now(),
    ),
    quantity:      h.quantity,
    selectedSize:  h.selectedSize,
    selectedColor: h.selectedColor,
  );
}