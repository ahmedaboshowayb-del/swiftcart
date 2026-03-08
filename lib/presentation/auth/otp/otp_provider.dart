import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../data/repositories/auth_repository_impl.dart';

part 'otp_provider.freezed.dart';
part 'otp_provider.g.dart';

@freezed
class OtpState with _$OtpState {
  const factory OtpState({
    @Default(false) bool    isVerifying,
    @Default(false) bool    isResending,
    @Default(false) bool    isSuccess,
    @Default(0)     int     resendCooldown,  
    UserEntity?             user,
    String?                 errorMessage,
  }) = _OtpState;
}

@riverpod
class OtpNotifier extends _$OtpNotifier {
  @override
  OtpState build() => const OtpState();

  Future<void> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    if (otp.length < 6) {
      state = state.copyWith(errorMessage: 'Please enter the full 6-digit code');
      return;
    }

    state = state.copyWith(isVerifying: true, errorMessage: null);

    final result = await ref.read(authRepositoryProvider).verifyPhoneOtp(
          verificationId: verificationId,
          otp: otp,
        );

    state = result.fold(
      (f) => state.copyWith(isVerifying: false, errorMessage: f.userMessage),
      (u) => state.copyWith(isVerifying: false, user: u, isSuccess: true),
    );
  }

  Future<void> resendOtp(String phoneNumber) async {
    state = state.copyWith(isResending: true, errorMessage: null);

    final result =
        await ref.read(authRepositoryProvider).sendPhoneOtp(phoneNumber);

    state = result.fold(
      (f) => state.copyWith(isResending: false, errorMessage: f.userMessage),
      (_) {
        _startCooldown();
        return state.copyWith(isResending: false, resendCooldown: 60);
      },
    );
  }

  void _startCooldown() async {
    for (int i = 60; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (state.resendCooldown > 0) {
        state = state.copyWith(resendCooldown: state.resendCooldown - 1);
      }
    }
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}