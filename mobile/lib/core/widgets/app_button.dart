import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AppButtonVariant { primary, outlined, text }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final double? width;
  final double height;
  final double borderRadius;
  final IconData? icon;
  final double fontSize;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.width,
    this.height = 16,
    this.borderRadius = 12,
    this.icon,
    this.fontSize = 16,
  });

  const AppButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height = 16,
    this.borderRadius = 12,
    this.icon,
    this.fontSize = 16,
  }) : variant = AppButtonVariant.primary;

  const AppButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height = 16,
    this.borderRadius = 12,
    this.icon,
    this.fontSize = 16,
  }) : variant = AppButtonVariant.outlined;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDisabled = onPressed == null;
    final disabledColor = colors.mutedForeground.withValues(alpha:0.4);

    final style = switch (variant) {
      AppButtonVariant.primary => TextButton.styleFrom(
        backgroundColor: isDisabled ? disabledColor : colors.primary,
        foregroundColor: isDisabled ? disabledColor : Colors.white,
        disabledBackgroundColor: disabledColor,
        disabledForegroundColor: disabledColor,
        padding: EdgeInsets.symmetric(vertical: height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      AppButtonVariant.outlined => TextButton.styleFrom(
        foregroundColor: isDisabled ? disabledColor : colors.mutedForeground,
        backgroundColor: colors.card,
        padding: EdgeInsets.symmetric(vertical: height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: isDisabled ? disabledColor : colors.border,
          ),
        ),
      ),
      AppButtonVariant.text => TextButton.styleFrom(
        foregroundColor: isDisabled ? disabledColor : colors.primary,
        padding: EdgeInsets.symmetric(vertical: height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    };

    final child = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        : Text(
            label,
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          );

    if (width != null) {
      return SizedBox(width: width, child: TextButton(onPressed: onPressed, style: style, child: child));
    }
    return TextButton(onPressed: onPressed, style: style, child: child);
  }
}

class AppIconCircleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback? onTap;

  const AppIconCircleButton({
    super.key,
    required this.icon,
    required this.label,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = enabled ? colors.foreground : colors.mutedForeground.withValues(alpha:0.6);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: colors.card,
          shape: BoxShape.circle,
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: colors.foreground.withValues(alpha:0.05),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
