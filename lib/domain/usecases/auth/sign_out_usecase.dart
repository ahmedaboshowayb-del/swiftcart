import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/utils/failure.dart';

class SignOutUseCase {
  const SignOutUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failure, void>> call() => _repo.signOut();
}