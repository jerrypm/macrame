import 'package:flutter/material.dart';

import '../config/themes/app_colors.dart';

class AppTextFormFieldWidget extends StatelessWidget {
  const AppTextFormFieldWidget({
    super.key,
    this.obscureText = false,
    this.onTap,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.readOnly = false,
    this.error,
    this.filled,
    this.fillColor,
    this.style,
    this.focusNode,
    this.enabledBorder,
    this.focusedBorder,
  });
  final Widget? error;
  final bool readOnly;
  final bool obscureText;
  final bool? filled;
  final String? hintText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final TextStyle? style;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onTap: onTap,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      cursorColor: Colors.black,
      cursorWidth: 1,
      focusNode: focusNode,
      style:
          style ?? const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        error: error,
        filled: filled,
        fillColor: fillColor,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.darkGrey,
          fontWeight: FontWeight.w400,
        ),
        errorText: errorText,
        contentPadding: contentPadding ??
            const EdgeInsets.only(left: 12, bottom: 0.5, right: 12),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFF0F1F9),
                width: 0.5,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 0.5,
          ),
        ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFD4C5B3),
                width: 0.5,
              ),
            ),
      ),
    );
  }
}
