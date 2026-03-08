import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth/sign_in_usecase.dart';
import '../../../data/repositories/auth_repository_impl.dart';

part 'login_provider.freezed.dart';
part 'login_provider.g.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool      isLoading,
    @Default(false) bool      isGoogleLoading,
    @Default(false) bool      isSuccess,
    UserEntity?               user,
    String?                   errorMessage,
  }) = _LoginState;
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() => const LoginState();

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final res = await SignInUseCase(ref.read(authRepositoryProvider))(
      SignInParams(email: email, password: password),
    );
    state = res.fold(
      (f) => state.copyWith(isLoading: false, errorMessage: f.userMessage),
      (u) => state.copyWith(isLoading: false, user: u, isSuccess: true),
    );
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isGoogleLoading: true, errorMessage: null);
    final res = await ref.read(authRepositoryProvider).signInWithGoogle();
    state = res.fold(
      (f) => state.copyWith(isGoogleLoading: false, errorMessage: f.userMessage),
      (u) => state.copyWith(isGoogleLoading: false, user: u, isSuccess: true),
    );
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}