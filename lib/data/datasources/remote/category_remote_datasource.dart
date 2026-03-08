import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/category_model.dart';
import '../../../core/constants/app_constants.dart';

part 'category_remote_datasource.g.dart';

@riverpod
CategoryRemoteDataSource categoryRemoteDataSource(
        CategoryRemoteDataSourceRef ref) =>
    CategoryRemoteDataSource(FirebaseFirestore.instance);

class CategoryRemoteDataSource {
  CategoryRemoteDataSource(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(AppConstants.categoriesCollection);

  Future<List<CategoryModel>> getCategories() async {
    final snap = await _col
        .where('is_active', isEqualTo: true)
        .get();
    final list = snap.docs.map(CategoryModel.fromFirestore).toList();
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }

  Future<CategoryModel> getCategoryById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) throw Exception('Category $id not found');
    return CategoryModel.fromFirestore(doc);
  }

  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    final snap = await _col
        .where('parent_id', isEqualTo: parentId)
        .where('is_active', isEqualTo: true)
        .get();
    final list = snap.docs.map(CategoryModel.fromFirestore).toList();
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }
}