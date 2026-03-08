import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/product_model.dart';
import '../../../core/constants/app_constants.dart';

part 'product_remote_datasource.g.dart';

@riverpod
ProductRemoteDataSource productRemoteDataSource(
        ProductRemoteDataSourceRef ref) =>
    ProductRemoteDataSource(FirebaseFirestore.instance);

class ProductRemoteDataSource {
  ProductRemoteDataSource(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(AppConstants.productsCollection);

  Future<List<ProductModel>> getFeaturedProducts() async {
    final snap = await _col
        .where('is_featured', isEqualTo: true)
        .limit(10)
        .get();
    return snap.docs.map(ProductModel.fromFirestore).toList();
  }

  Future<List<ProductModel>> getNewArrivals() async {
    final snap = await _col
        .where('is_new', isEqualTo: true)
        .limit(10)
        .get();
    return snap.docs.map(ProductModel.fromFirestore).toList();
  }

  Future<List<ProductModel>> getProducts({
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? sortBy,
    int limit = 20,
  }) async {
    Query<Map<String, dynamic>> q = _col
        .where('is_active', isEqualTo: true);

    if (categoryId != null) {
      q = q.where('category_id', isEqualTo: categoryId);
    }

    final snap = await q.limit(limit).get();
    List<ProductModel> results =
        snap.docs.map(ProductModel.fromFirestore).toList();

    if (minPrice != null) {
      results = results
          .where((p) => p.price >= minPrice)
          .toList();
    }
    if (maxPrice != null) {
      results = results
          .where((p) => p.price <= maxPrice)
          .toList();
    }
    if (minRating != null) {
      results = results
          .where((p) => p.rating >= minRating)
          .toList();
    }

    switch (sortBy) {
      case 'price_asc':
        results.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_desc':
        results.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        results.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return results;
  }

  Future<ProductModel> getProductById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) throw Exception('Product $id not found');
    return ProductModel.fromFirestore(doc);
  }

  Future<List<ProductModel>> getSimilarProducts(
      String productId, String categoryId) async {
    final snap = await _col
        .where('category_id', isEqualTo: categoryId)
        .limit(10)
        .get();

    return snap.docs
        .map(ProductModel.fromFirestore)
        .where((p) => p.id != productId) 
        .take(8)
        .toList();
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final snap = await _col
        .where('is_active', isEqualTo: true)
        .limit(100)
        .get();

    final lower = query.toLowerCase();
    return snap.docs
        .map(ProductModel.fromFirestore)
        .where((p) =>
            p.name.toLowerCase().contains(lower) ||
            p.brand.toLowerCase().contains(lower) ||
            p.tags.any((t) => t.toLowerCase().contains(lower)))
        .toList();
  }
}