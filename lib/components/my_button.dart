import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
        child: Center(
          child: Text(
            text,
          ),
        )
    );
  }
}

// GestureDetector(
// onTap: onTap,
// child: Container(
// decoration: BoxDecoration(
// color: Colors.black,
// borderRadius: BorderRadius.circular(15)
// ),
// child: Center(
// child: Text(
// text,
// style: TextStyle(
// color: Colors.white,
// fontSize: 16,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// padding: EdgeInsets.all(10),
// ),
// );