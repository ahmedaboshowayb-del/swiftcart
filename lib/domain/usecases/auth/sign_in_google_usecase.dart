import 'package:dartz/dartz.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/utils/failure.dart';

class SignInWithGoogleUseCase {
  const SignInWithGoogleUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failure, UserEntity>> call() =>
      _repo.signInWithGoogle();
}