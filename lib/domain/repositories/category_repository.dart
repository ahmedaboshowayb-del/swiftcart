import 'package:dartz/dartz.dart';
import '../entities/category_entity.dart';
import '../../core/utils/failure.dart';

abstract interface class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, CategoryEntity>>       getCategoryById(String id);
}