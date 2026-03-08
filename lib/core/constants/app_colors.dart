import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary        = Color(0xFFFF6B35); 
  static const Color primaryDark    = Color(0xFFE55A25);
  static const Color primaryLight   = Color(0xFFFF8C5A);
  static const Color primaryContainer = Color(0xFFFFEDE6);

  static const Color secondary      = Color(0xFF1A1A2E);
  static const Color secondaryDark  = Color(0xFF0F0F1A);
  static const Color secondaryLight = Color(0xFF2D2D4E);

  static const Color accent         = Color(0xFF00C896);

  static const Color white    = Color(0xFFFFFFFF);
  static const Color black    = Color(0xFF000000);
  static const Color grey50   = Color(0xFFFAFAFA);
  static const Color grey100  = Color(0xFFF5F5F5);
  static const Color grey200  = Color(0xFFEEEEEE);
  static const Color grey300  = Color(0xFFE0E0E0);
  static const Color grey400  = Color(0xFFBDBDBD);
  static const Color grey500  = Color(0xFF9E9E9E);
  static const Color grey600  = Color(0xFF757575);
  static const Color grey700  = Color(0xFF616161);
  static const Color grey800  = Color(0xFF424242);
  static const Color grey900  = Color(0xFF212121);

  static const Color success      = Color(0xFF00C896);
  static const Color successLight = Color(0xFFE6FBF6);
  static const Color warning      = Color(0xFFFFB800);
  static const Color warningLight = Color(0xFFFFF8E6);
  static const Color error        = Color(0xFFFF3B30);
  static const Color errorLight   = Color(0xFFFFECEB);
  static const Color info         = Color(0xFF007AFF);
  static const Color infoLight    = Color(0xFFE8F1FF);

  static const Color statusPreparing = Color(0xFFFFB800);
  static const Color statusOnTheWay  = Color(0xFF007AFF);
  static const Color statusDelivered = Color(0xFF00C896);
  static const Color statusCancelled = Color(0xFFFF3B30);

  static const Color lightBackground    = Color(0xFFF8F8FA);
  static const Color lightSurface       = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF3F4F6);
  static const Color lightBorder        = Color(0xFFE8E8EC);
  static const Color lightDivider       = Color(0xFFF0F0F3);

  static const Color darkBackground    = Color(0xFF0C0C14);
  static const Color darkSurface       = Color(0xFF151520);
  static const Color darkSurfaceVariant = Color(0xFF1E1E2E);
  static const Color darkBorder        = Color(0xFF2A2A3E);
  static const Color darkDivider       = Color(0xFF232333);

  static const Color textPrimary      = Color(0xFF1A1A2E);
  static const Color textSecondary    = Color(0xFF6B7280);
  static const Color textTertiary     = Color(0xFF9CA3AF);
  static const Color textDisabled     = Color(0xFFD1D5DB);
  static const Color textOnPrimary    = Color(0xFFFFFFFF);
  static const Color textDarkPrimary  = Color(0xFFF9FAFB);
  static const Color textDarkSecondary = Color(0xFF9CA3AF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFF8C5A), Color(0xFFFFB347)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: const Color(0xFF1A1A2E).withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get primaryShadow => [
    BoxShadow(
      color: primary.withOpacity(0.35),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}