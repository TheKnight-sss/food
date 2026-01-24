import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food/core/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.validator,
    this.controller,
    this.maxLines,
    this.minLines,
    this.suffixIcon,
    this.readOnly,
    this.onTap,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.keyboardType,
  });

  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: readOnly ?? false,
      onTap: onTap,
      keyboardType: keyboardType,
      textAlign: textAlign,
      textDirection: TextDirection.rtl,
      // Allow callers to supply optional inputFormatters per-field. If
      // null, no additional filtering will be applied and the native
      // keyboard input is accepted.
      inputFormatters: inputFormatters,
      decoration: InputDecoration(hintText: hint, suffixIcon: suffixIcon,fillColor: AppColors.accentcolor3),
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
