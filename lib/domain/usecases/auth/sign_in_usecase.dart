import 'package:dartz/dartz.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/utils/failure.dart';

class SignInParams {
  const SignInParams({required this.email, required this.password});
  final String email;
  final String password;
}

class SignInUseCase {
  const SignInUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failure, UserEntity>> call(SignInParams p) =>
      _repo.signInWithEmail(email: p.email, password: p.password);
}