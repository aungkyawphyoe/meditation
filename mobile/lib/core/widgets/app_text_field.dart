import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool compact;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.compact = false,
  });

  AppTextField.compact({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  }) : compact = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(fontFamily: 'Geist', fontSize: 16),
          decoration: compact
              ? InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF2F3F0),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                )
              : InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    color: Color(0xFF999999),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
