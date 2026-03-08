import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

abstract final class AppTheme {

  static ThemeData get light => _build(isDark: false);

  static ThemeData get dark => _build(isDark: true);

  static ThemeData _build({required bool isDark}) {
    final colorScheme = isDark ? _darkScheme : _lightScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme:  colorScheme,

      scaffoldBackgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,

      fontFamily: 'Poppins',

      textTheme: _textTheme(isDark: isDark),

      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        foregroundColor:
            isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize:   18,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:          Colors.transparent,
          statusBarIconBrightness:
              isDark ? Brightness.light : Brightness.dark,
        ),
      ),

cardTheme: CardThemeData(
  color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: BorderSide(
      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
    ),
  ),
  margin: EdgeInsets.zero,
),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation:       0,
          minimumSize:     const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize:   16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize:   16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize:   14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled:      true,
        fillColor:   isDark
            ? AppColors.darkSurfaceVariant
            : AppColors.lightSurfaceVariant,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.error, width: 1.5),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize:   14,
          color: isDark ? AppColors.grey600 : AppColors.grey400,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize:   14,
          color: isDark ? AppColors.grey500 : AppColors.grey500,
        ),
        prefixIconColor:
            isDark ? AppColors.grey500 : AppColors.grey500,
      ),

      dividerTheme: DividerThemeData(
        color:     isDark ? AppColors.darkDivider : AppColors.lightDivider,
        thickness: 1,
        space:     0,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor:
            isDark ? AppColors.darkSurfaceVariant : AppColors.secondary,
        contentTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize:   14,
          color: isDark ? AppColors.textDarkPrimary : Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior:  SnackBarBehavior.floating,
        elevation: 4,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: isDark
            ? AppColors.darkSurfaceVariant
            : AppColors.lightSurfaceVariant,
        selectedColor: isDark
            ? const Color(0xFF3D1A0A)
            : AppColors.primaryContainer,
        labelStyle: TextStyle(
          fontFamily:  'Poppins',
          fontSize:    13,
          fontWeight:  FontWeight.w500,
          color: isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor:
            isDark ? AppColors.darkSurface : AppColors.lightSurface,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(24)),
        ),
        elevation: 8,
      ),

      listTileTheme: ListTileThemeData(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        iconColor:
            isDark ? AppColors.textDarkSecondary : AppColors.textSecondary,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize:   14,
          fontWeight: FontWeight.w500,
          color:
              isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return isDark ? AppColors.grey600 : AppColors.grey400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withOpacity(0.4);
          }
          return isDark ? AppColors.grey700 : AppColors.grey200;
        }),
      ),
    );
  }

  static TextTheme _textTheme({required bool isDark}) {
    final primary   = isDark ? AppColors.textDarkPrimary   : AppColors.textPrimary;
    final secondary = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;

    return TextTheme(
      displayLarge:   _ts(57, FontWeight.w700, primary,   letterSpacing: -0.5),
      displayMedium:  _ts(45, FontWeight.w700, primary),
      displaySmall:   _ts(36, FontWeight.w600, primary),
      headlineLarge:  _ts(28, FontWeight.w700, primary),
      headlineMedium: _ts(24, FontWeight.w600, primary),
      headlineSmall:  _ts(20, FontWeight.w600, primary),
      titleLarge:     _ts(18, FontWeight.w600, primary),
      titleMedium:    _ts(16, FontWeight.w500, primary),
      titleSmall:     _ts(14, FontWeight.w500, primary),
      bodyLarge:      _ts(16, FontWeight.w400, primary),
      bodyMedium:     _ts(14, FontWeight.w400, secondary),
      bodySmall:      _ts(12, FontWeight.w400, secondary),
      labelLarge:     _ts(14, FontWeight.w600, primary),
      labelMedium:    _ts(12, FontWeight.w500, secondary),
      labelSmall:     _ts(11, FontWeight.w500, secondary),
    );
  }

  static TextStyle _ts(
    double size,
    FontWeight weight,
    Color color, {
    double? letterSpacing,
  }) =>
      TextStyle(
        fontFamily:    'Poppins',
        fontSize:      size,
        fontWeight:    weight,
        color:         color,
        letterSpacing: letterSpacing,
      );

  static const ColorScheme _lightScheme = ColorScheme.light(
    primary:            AppColors.primary,
    onPrimary:          AppColors.white,
    primaryContainer:   AppColors.primaryContainer,
    onPrimaryContainer: AppColors.primaryDark,
    secondary:          AppColors.secondary,
    onSecondary:        AppColors.white,
    surface:            AppColors.lightSurface,
    onSurface:          AppColors.textPrimary,
    error:              AppColors.error,
    onError:            AppColors.white,
    outline:            AppColors.lightBorder,
  );

  static const ColorScheme _darkScheme = ColorScheme.dark(
    primary:            AppColors.primary,
    onPrimary:          AppColors.white,
    primaryContainer:   Color(0xFF3D1A0A),
    onPrimaryContainer: AppColors.primaryLight,
    secondary:          AppColors.secondaryLight,
    onSecondary:        AppColors.white,
    surface:            AppColors.darkSurface,
    onSurface:          AppColors.textDarkPrimary,
    error:              AppColors.error,
    onError:            AppColors.white,
    outline:            AppColors.darkBorder,
  );
}