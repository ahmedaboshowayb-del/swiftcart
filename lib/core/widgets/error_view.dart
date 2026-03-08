import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import 'app_button.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.onRetry, this.compact = false});
  final String message;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 32),
        const SizedBox(height: 8),
        Text(message, textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, color: AppColors.textSecondary)),
        if (onRetry != null) ...[
          const SizedBox(height: 8),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ]));
    }

    return Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 80, height: 80,
          decoration: const BoxDecoration(color: AppColors.errorLight, shape: BoxShape.circle),
          child: const Icon(Icons.wifi_off_rounded, color: AppColors.error, size: 36),
        ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),

        const SizedBox(height: 20),
        const Text('Oops!', style: TextStyle(fontFamily: 'Poppins', fontSize: 22,
            fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Text(message, textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.textSecondary)),

        if (onRetry != null) ...[
          const SizedBox(height: 24),
          AppButton(label: 'Try Again', onPressed: onRetry,
              fullWidth: false, size: AppButtonSize.md),
        ],
      ],
    )));
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.title, required this.subtitle,
    this.action, this.actionLabel});
  final String title, subtitle;
  final VoidCallback? action;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) => Center(child: Padding(
    padding: const EdgeInsets.all(32),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 100, height: 100,
        decoration: const BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
        child: const Icon(Icons.inbox_outlined, color: AppColors.primary, size: 44),
      ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),

      const SizedBox(height: 24),
      Text(title, style: const TextStyle(fontFamily: 'Poppins', fontSize: 20,
          fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: 8),
      Text(subtitle, textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.textSecondary)),

      if (action != null && actionLabel != null) ...[
        const SizedBox(height: 24),
        AppButton(label: actionLabel!, onPressed: action,
            fullWidth: false, size: AppButtonSize.md),
      ],
    ]),
  ));
}