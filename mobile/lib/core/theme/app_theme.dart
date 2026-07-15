import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color primary;
  final Color foreground;
  final Color card;
  final Color secondary;
  final Color mutedForeground;
  final Color border;

  const AppColors({
    required this.background,
    required this.primary,
    required this.foreground,
    required this.card,
    required this.secondary,
    required this.mutedForeground,
    required this.border,
  });

  static const light = AppColors(
    background: Color(0xFFF2F3F0),
    primary: Color(0xFFFF8400),
    foreground: Color(0xFF111111),
    card: Color(0xFFFFFFFF),
    secondary: Color(0xFFE7E8E5),
    mutedForeground: Color(0xFF666666),
    border: Color(0xFFCBCCC9),
  );

  static const dark = AppColors(
    background: Color(0xFF121212),
    primary: Color(0xFFFFB74D),
    foreground: Color(0xFFE6E1E5),
    card: Color(0xFF1E1E1E),
    secondary: Color(0xFF2B2930),
    mutedForeground: Color(0xFF9E9E9E),
    border: Color(0xFF3C3C3C),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? primary,
    Color? foreground,
    Color? card,
    Color? secondary,
    Color? mutedForeground,
    Color? border,
  }) {
    return AppColors(
      background: background ?? this.background,
      primary: primary ?? this.primary,
      foreground: foreground ?? this.foreground,
      card: card ?? this.card,
      secondary: secondary ?? this.secondary,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      border: border ?? this.border,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      card: Color.lerp(card, other.card, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colors = AppColors.light;
    final colorScheme = ColorScheme.light(
      primary: colors.primary,
      onPrimary: Colors.white,
      primaryContainer: colors.primary.withAlpha(25),
      surface: colors.background,
      onSurface: colors.foreground,
      surfaceContainerHighest: colors.secondary,
      onSurfaceVariant: colors.mutedForeground,
      outlineVariant: colors.border,
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: colors.background,
      colorScheme: colorScheme,
      fontFamily: 'Geist',
      extensions: [colors],
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Geist',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: colors.foreground,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Geist',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colors.foreground,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Geist',
          fontSize: 12,
          color: colors.mutedForeground,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Geist',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: colors.mutedForeground,
        ),
      ),
    );
  }

  static ThemeData get dark {
    final colors = AppColors.dark;
    final colorScheme = ColorScheme.dark(
      primary: colors.primary,
      onPrimary: const Color(0xFF111111),
      primaryContainer: colors.primary.withAlpha(25),
      surface: colors.background,
      onSurface: colors.foreground,
      surfaceContainerHighest: colors.secondary,
      onSurfaceVariant: colors.mutedForeground,
      outlineVariant: colors.border,
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: colors.background,
      colorScheme: colorScheme,
      fontFamily: 'Geist',
      extensions: [colors],
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Geist',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: colors.foreground,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Geist',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colors.foreground,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Geist',
          fontSize: 12,
          color: colors.mutedForeground,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Geist',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: colors.mutedForeground,
        ),
      ),
    );
  }
}

extension BuildContextColors on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
