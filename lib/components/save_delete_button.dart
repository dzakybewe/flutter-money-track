import 'package:flutter/material.dart';

class SaveDeleteButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  SaveDeleteButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 12
        ),
      ),
      color: Colors.black,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
