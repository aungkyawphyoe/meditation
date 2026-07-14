import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppBadge extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double? letterSpacing;

  const AppBadge({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.fontSize = 11,
    this.fontWeight = FontWeight.w600,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius = 6,
    this.letterSpacing,
  });

  AppBadge.mode({
    super.key,
    required this.text,
  }) : color = AppColors.primary.withAlpha(25),
       textColor = AppColors.primary,
       fontSize = 12,
       fontWeight = FontWeight.w500,
       padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
       borderRadius = 16,
       letterSpacing = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppColors.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Geist',
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor ?? AppColors.primary,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}

class AppDayIndicator extends StatelessWidget {
  final int number;
  final double size;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;

  const AppDayIndicator({
    super.key,
    required this.number,
    this.size = 28,
    this.borderRadius = 6,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}

class AppStatusBadge extends StatelessWidget {
  final String label;
  final Color statusColor;

  const AppStatusBadge({
    super.key,
    required this.label,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Geist',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: statusColor,
        ),
      ),
    );
  }
}
