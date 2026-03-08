import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/utils/failure.dart';
import '../datasources/remote/auth_remote_datasource.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      return (await _remote.getCurrentUser()).toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges =>
      _remote.authStateChanges.asyncMap((u) async {
        if (u == null) return null;
        try { return (await _remote.getCurrentUser()).toEntity(); }
        catch (_) { return null; }
      });

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({required String email, required String password}) =>
      _guard(() async => (await _remote.signInWithEmail(email, password)).toEntity());

  @override
  Future<Either<Failure, UserEntity>> registerWithEmail({required String email, required String password, required String fullName}) =>
      _guard(() async => (await _remote.registerWithEmail(email, password, fullName)).toEntity());

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() =>
      _guard(() async => (await _remote.signInWithGoogle()).toEntity());

  @override
  Future<Either<Failure, String>> sendPhoneOtp(String phone) =>
      _guard(() => _remote.sendPhoneOtp(phone));

  @override
  Future<Either<Failure, UserEntity>> verifyPhoneOtp({required String verificationId, required String otp}) =>
      _guard(() async => (await _remote.verifyPhoneOtp(verificationId, otp)).toEntity());

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) =>
      _guard(() => _remote.sendPasswordResetEmail(email));

  @override
  Future<Either<Failure, void>> signOut() =>
      _guard(() => _remote.signOut());

  @override
  Future<Either<Failure, UserEntity>> updateProfile({String? fullName, String? photoUrl, String? phoneNumber}) =>
      _guard(() async => (await _remote.updateProfile(fullName: fullName, photoUrl: photoUrl, phoneNumber: phoneNumber)).toEntity());

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(_authMsg(e.code), code: e.code));
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  String _authMsg(String code) => switch (code) {
    'user-not-found'     => 'No account found with this email.',
    'wrong-password'     => 'Incorrect password. Please try again.',
    'email-already-in-use' => 'This email is already registered.',
    'weak-password'      => 'Password is too weak.',
    'invalid-email'      => 'Please enter a valid email.',
    'too-many-requests'  => 'Too many attempts. Please try again later.',
    'network-request-failed' => 'Network error. Check your connection.',
    _                    => 'Authentication failed. Please try again.',
  };
}