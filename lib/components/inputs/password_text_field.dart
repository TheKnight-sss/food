import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.validator,
    this.controller,

    this.readOnly,
    this.onTap,
    this.maxLines,
    required this.textAlign,
  });

  final String? hint;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final int? maxLines;
  final TextAlign textAlign;

  final bool? readOnly;
  final Function()? onTap;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      validator: widget.validator,
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hintText: widget.hint,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
