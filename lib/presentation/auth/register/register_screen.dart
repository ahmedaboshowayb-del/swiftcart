import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import 'register_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey   = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  final _confCtrl  = TextEditingController();
  bool  _hidePass  = true;
  bool  _hideConf  = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(registerNotifierProvider.notifier).register(
          fullName: _nameCtrl.text.trim(),
          email:    _emailCtrl.text.trim(),
          password: _passCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerNotifierProvider);

    ref.listen(registerNotifierProvider, (_, next) {
      if (next.isSuccess) context.go(AppRoutes.home);
      if (next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
        ref.read(registerNotifierProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account 👋',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: -0.1, end: 0),

                const SizedBox(height: 8),

                const Text(
                  'Join SwiftCart for the best deals',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ).animate(delay: 80.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 32),

                TextFormField(
                  controller: _nameCtrl,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: Validators.fullName,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'John Doe',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                )
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: -0.1, end: 0),

                const SizedBox(height: 16),

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
                )
                    .animate(delay: 150.ms)
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: -0.1, end: 0),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _passCtrl,
                  obscureText: _hidePass,
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_hidePass
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () =>
                          setState(() => _hidePass = !_hidePass),
                    ),
                  ),
                )
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: -0.1, end: 0),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _confCtrl,
                  obscureText: _hideConf,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: (v) =>
                      Validators.confirmPassword(v, _passCtrl.text),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_hideConf
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () =>
                          setState(() => _hideConf = !_hideConf),
                    ),
                  ),
                )
                    .animate(delay: 250.ms)
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: -0.1, end: 0),

                const SizedBox(height: 12),

                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      TextSpan(text: 'By registering, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 300.ms).fadeIn(duration: 300.ms),

                const SizedBox(height: 28),

                AppButton(
                  label: 'Create Account',
                  onPressed: _submit,
                  isLoading: state.isLoading,
                  icon: const Icon(Icons.person_add_outlined),
                )
                    .animate(delay: 350.ms)
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 24),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 400.ms).fadeIn(duration: 300.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}