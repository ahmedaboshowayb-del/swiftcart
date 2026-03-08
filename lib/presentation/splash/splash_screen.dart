import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routing/app_router.dart';
import '../../data/repositories/auth_repository_impl.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2400));
    if (!mounted) return;
    final user = await ref.read(authRepositoryProvider).getCurrentUser();
    if (!mounted) return;
    context.go(user != null ? AppRoutes.home : AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30, offset: const Offset(0, 10),
                )],
              ),
              child: const Icon(Icons.shopping_cart_rounded, color: AppColors.primary, size: 50),
            )
            .animate()
            .scale(duration: 600.ms, curve: Curves.elasticOut),

            const SizedBox(height: 24),

            const Text(
              'SwiftCart',
              style: TextStyle(
                fontFamily: 'Poppins', fontSize: 36,
                fontWeight: FontWeight.w700, color: Colors.white,
              ),
            )
            .animate(delay: 300.ms)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 8),

            const Text(
              'Shop Smart. Deliver Fast.',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white70),
            )
            .animate(delay: 500.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 64),

            SizedBox(
              width: 36, height: 36,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation(Colors.white.withOpacity(0.6)),
              ),
            )
            .animate(delay: 800.ms).fadeIn(),
          ],
        ),
      ),
    );
  }
}