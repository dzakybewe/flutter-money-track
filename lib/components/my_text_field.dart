import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final controller;
  final bool obscureText;
  final VoidCallback? onTap;
  final Icon? leadingIcon;
  final bool? readOnly;
  final TextInputType inputType;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    this.onTap,
    this.leadingIcon,
    this.readOnly,
    required this.inputType
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: readOnly,
      readOnly: readOnly != null ? true : false,
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,
      decoration: InputDecoration(
        suffixIcon: leadingIcon,
        fillColor: const Color(0xFFDDDDDD).withAlpha(30),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.all(10)
      ),
      onTap: onTap,
    );
  }
}
