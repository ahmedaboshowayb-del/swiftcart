import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../../core/utils/failure.dart';

abstract interface class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> get authStateChanges;

  Future<Either<Failure, UserEntity>> signInWithEmail({required String email, required String password});
  Future<Either<Failure, UserEntity>> registerWithEmail({required String email, required String password, required String fullName});
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, String>>     sendPhoneOtp(String phoneNumber);
  Future<Either<Failure, UserEntity>> verifyPhoneOtp({required String verificationId, required String otp});
  Future<Either<Failure, void>>       sendPasswordResetEmail(String email);
  Future<Either<Failure, void>>       signOut();
  Future<Either<Failure, UserEntity>> updateProfile({String? fullName, String? photoUrl, String? phoneNumber});
}