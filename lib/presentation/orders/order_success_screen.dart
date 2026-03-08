import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routing/app_router.dart';
import '../../core/widgets/app_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 64,
                ),
              )
                  .animate()
                  .scale(
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                  )
                  .fadeIn(duration: 300.ms),

              const SizedBox(height: 32),

              const Text(
                'Order Placed! 🎉',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              )
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 12),

              const Text(
                'Your order has been confirmed and\nwill be delivered soon.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              )
                  .animate(delay: 400.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.warningLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.schedule_rounded,
                        color: AppColors.warning, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Estimated delivery: 30–45 minutes',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: 500.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 48),

              AppButton(
                label: 'Track My Order',
                onPressed: () => context.go(AppRoutes.orders),
                icon: const Icon(Icons.location_on_outlined),
              )
                  .animate(delay: 600.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 12),

              AppButton(
                label: 'Continue Shopping',
                onPressed: () => context.go(AppRoutes.home),
                variant: AppButtonVariant.outlined,
              )
                  .animate(delay: 700.ms)
                  .fadeIn(duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}