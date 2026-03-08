import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import 'login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey  = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool  _hidePass  = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(loginNotifierProvider.notifier)
        .signIn(_emailCtrl.text.trim(), _passCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(loginNotifierProvider);

    ref.listen(loginNotifierProvider, (_, next) {
      if (next.isSuccess) context.go(AppRoutes.home);
      if (next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
        ref.read(loginNotifierProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                Row(children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.shopping_cart_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 10),
                  const Text('SwiftCart', style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 22,
                    fontWeight: FontWeight.w700, color: AppColors.primary,
                  )),
                ]).animate().fadeIn(duration: 400.ms),

                const SizedBox(height: 36),

                Text('Welcome back! 👋', style: context.textTheme.headlineMedium)
                    .animate(delay: 100.ms).fadeIn().slideY(begin: -0.1, end: 0),
                const SizedBox(height: 8),
                const Text('Sign in to continue', style: TextStyle(color: AppColors.textSecondary))
                    .animate(delay: 150.ms).fadeIn(),

                const SizedBox(height: 36),

                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'name@example.com',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.1, end: 0),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _passCtrl,
                  obscureText: _hidePass,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: Validators.password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_hidePass
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () => setState(() => _hidePass = !_hidePass),
                    ),
                  ),
                ).animate(delay: 250.ms).fadeIn().slideX(begin: -0.1, end: 0),

                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),

                const SizedBox(height: 8),

                AppButton(
                  label: 'Login',
                  onPressed: _submit,
                  isLoading: s.isLoading,
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2, end: 0),

                const SizedBox(height: 24),

                Row(children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or continue with',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary,
                            fontFamily: 'Poppins')),
                  ),
                  const Expanded(child: Divider()),
                ]).animate(delay: 350.ms).fadeIn(),

                const SizedBox(height: 24),

                _SocialButton(
                  label: 'Continue with Google',
                  icon: const Icon(Icons.g_mobiledata_rounded, size: 26),
                  isLoading: s.isGoogleLoading,
                  onTap: () => ref.read(loginNotifierProvider.notifier).signInWithGoogle(),
                ).animate(delay: 400.ms).fadeIn(),

                const SizedBox(height: 12),

                _SocialButton(
                  label: 'Continue with Phone',
                  icon: const Icon(Icons.phone_outlined, size: 20),
                  onTap: () => context.push(AppRoutes.otp,
                      extra: {'phone': '', 'vid': ''}),
                ).animate(delay: 450.ms).fadeIn(),

                const SizedBox(height: 36),

                Center(child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Don't have an account? ",
                        style: TextStyle(color: AppColors.textSecondary, fontFamily: 'Poppins')),
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.register),
                      child: const Text('Register', style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      )),
                    ),
                  ],
                )).animate(delay: 500.ms).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    this.onTap,
    this.isLoading = false,
  });
  final String   label;
  final Widget   icon;
  final VoidCallback? onTap;
  final bool     isLoading;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1.5,
          ),
        ),
        child: isLoading
            ? const Center(child: SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary)))
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                icon,
                const SizedBox(width: 10),
                Text(label, style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
                )),
              ]),
      ),
    );
  }
}