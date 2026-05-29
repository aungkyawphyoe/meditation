import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFFF2F3F0);
  static const Color primary = Color(0xFFFF8400);
  static const Color foreground = Color(0xFF111111);
  static const Color card = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFFE7E8E5);
  static const Color mutedForeground = Color(0xFF666666);
  static const Color border = Color(0xFFCBCCC9);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.background,
        onSurface: AppColors.foreground,
      ),
      fontFamily: 'Geist',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Geist',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.foreground,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Geist',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.foreground,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Geist',
          fontSize: 12,
          color: AppColors.mutedForeground,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Geist',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: AppColors.mutedForeground,
        ),
      ),
    );
  }
}
