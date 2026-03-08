import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_button.dart';
import 'otp_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });
  final String phoneNumber;
  final String verificationId;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes   = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes)   f.dispose();
    super.dispose();
  }

  String get _otp =>
      _controllers.map((c) => c.text).join();

  void _onDigitEntered(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (_otp.length == 6) {
      _verify();
    }
  }

  Future<void> _verify() async {
    await ref.read(otpNotifierProvider.notifier).verifyOtp(
          verificationId: widget.verificationId,
          otp: _otp,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(otpNotifierProvider);

    ref.listen(otpNotifierProvider, (_, next) {
      if (next.isSuccess) context.go(AppRoutes.home);
      if (next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
        ref.read(otpNotifierProvider.notifier).clearError();
        for (final c in _controllers) c.clear();
        _focusNodes.first.requestFocus();
      }
    });

    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              const Text(
                'Verify your\nphone number',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: -0.1, end: 0),

              const SizedBox(height: 12),

              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    const TextSpan(text: 'Code sent to '),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (i) => _DigitBox(
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    onChanged: (v) => _onDigitEntered(i, v),
                  ),
                ),
              ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 40),

              AppButton(
                label: 'Verify',
                onPressed: _verify,
                isLoading: state.isVerifying,
                icon: const Icon(Icons.verified_outlined),
              ).animate(delay: 300.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 24),

              Center(
                child: state.resendCooldown > 0
                    ? Text(
                        'Resend code in ${state.resendCooldown}s',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      )
                    : GestureDetector(
                        onTap: state.isResending
                            ? null
                            : () => ref
                                .read(otpNotifierProvider.notifier)
                                .resendOtp(widget.phoneNumber),
                        child: state.isResending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              )
                            : RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 14),
                                  children: [
                                    TextSpan(
                                        text: "Didn't receive the code? ",
                                        style: TextStyle(
                                            color: AppColors.textSecondary)),
                                    TextSpan(
                                      text: 'Resend',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
              ).animate(delay: 400.ms).fadeIn(duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}


class _DigitBox extends StatelessWidget {
  const _DigitBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });
  final TextEditingController controller;
  final FocusNode             focusNode;
  final ValueChanged<String>  onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 58,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: context.isDark
              ? AppColors.textDarkPrimary
              : AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: focusNode.hasFocus
              ? AppColors.primaryContainer
              : (context.isDark
                  ? AppColors.darkSurfaceVariant
                  : AppColors.lightSurfaceVariant),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: focusNode.hasFocus
                  ? AppColors.primary
                  : (context.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: context.isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}