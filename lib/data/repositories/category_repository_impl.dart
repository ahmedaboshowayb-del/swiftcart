import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../../core/utils/failure.dart';
import '../datasources/remote/category_remote_datasource.dart';

part 'category_repository_impl.g.dart';

@riverpod
CategoryRepository categoryRepository(CategoryRepositoryRef ref) =>
    CategoryRepositoryImpl(ref.watch(categoryRemoteDataSourceProvider));

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._remote);
  final CategoryRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() =>
      _guard(() async {
        final models = await _remote.getCategories();
        return models.map((m) => m.toEntity()).toList();
      });

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(String id) =>
      _guard(() async => (await _remote.getCategoryById(id)).toEntity());

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Firebase error', code: e.code));
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}