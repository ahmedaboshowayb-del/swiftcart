import 'package:dartz/dartz.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/utils/failure.dart';

class RegisterParams {
  const RegisterParams({required this.email, required this.password, required this.fullName});
  final String email, password, fullName;
}

class RegisterUseCase {
  const RegisterUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failure, UserEntity>> call(RegisterParams p) =>
      _repo.registerWithEmail(email: p.email, password: p.password, fullName: p.fullName);
}