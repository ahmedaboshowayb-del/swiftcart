import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth/register_usecase.dart';
import '../../../data/repositories/auth_repository_impl.dart';

part 'register_provider.freezed.dart';
part 'register_provider.g.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool    isLoading,
    @Default(false) bool    isSuccess,
    UserEntity?             user,
    String?                 errorMessage,
  }) = _RegisterState;
}

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() => const RegisterState();

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await RegisterUseCase(ref.read(authRepositoryProvider))(
      RegisterParams(
        fullName: fullName,
        email:    email,
        password: password,
      ),
    );

    state = result.fold(
      (f) => state.copyWith(isLoading: false, errorMessage: f.userMessage),
      (u) => state.copyWith(isLoading: false, user: u, isSuccess: true),
    );
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}