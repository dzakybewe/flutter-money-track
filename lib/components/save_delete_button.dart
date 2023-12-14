import 'package:flutter/material.dart';

class SaveDeleteButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const SaveDeleteButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.black,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 12
        ),
      ),
    );
  }
}
