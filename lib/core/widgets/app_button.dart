import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum AppButtonVariant { primary, outlined, ghost, danger }
enum AppButtonSize    { sm, md, lg }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading  = false,
    this.variant    = AppButtonVariant.primary,
    this.size       = AppButtonSize.lg,
    this.fullWidth  = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isLoading;
  final AppButtonVariant variant;
  final AppButtonSize    size;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;

    final h = switch (size) { AppButtonSize.sm => 38.0, AppButtonSize.md => 46.0, AppButtonSize.lg => 54.0 };
    final fs = switch (size) { AppButtonSize.sm => 13.0, AppButtonSize.md => 14.0, AppButtonSize.lg => 16.0 };

    final Color bg = switch (variant) {
      AppButtonVariant.primary  => disabled ? AppColors.grey300 : AppColors.primary,
      AppButtonVariant.outlined => Colors.transparent,
      AppButtonVariant.ghost    => Colors.transparent,
      AppButtonVariant.danger   => disabled ? AppColors.grey300 : AppColors.error,
    };

    final Color fg = switch (variant) {
      AppButtonVariant.primary  => Colors.white,
      AppButtonVariant.outlined => disabled ? AppColors.grey400 : AppColors.primary,
      AppButtonVariant.ghost    => AppColors.primary,
      AppButtonVariant.danger   => Colors.white,
    };

    final Border border = switch (variant) {
      AppButtonVariant.outlined => Border.all(
        color: disabled ? AppColors.grey300 : AppColors.primary, width: 1.5),
      _ => Border.all(color: Colors.transparent),
    };

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: fullWidth ? double.infinity : null,
        height: h,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: border,
          boxShadow: variant == AppButtonVariant.primary && !disabled
              ? AppColors.primaryShadow
              : [],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(width: 22, height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation(fg)))
              : Row(mainAxisSize: MainAxisSize.min, children: [
                  if (icon != null) ...[
                    IconTheme(data: IconThemeData(color: fg, size: fs + 2), child: icon!),
                    const SizedBox(width: 8),
                  ],
                  Text(label, style: TextStyle(
                    fontFamily: 'Poppins', fontSize: fs,
                    fontWeight: FontWeight.w600, color: fg,
                  )),
                ]),
        ),
      ),
    );
  }
}