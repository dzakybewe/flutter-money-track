import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/colors.dart';

class MyButton extends StatelessWidget {
  final String text;

  final void Function()? onTap;

  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: appButtonPrimary,
        borderRadius: BorderRadius.circular(25)
      ),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
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
              style: const TextStyle(color: Colors.white),
            ),
          )
      ),
    );
  }
}
