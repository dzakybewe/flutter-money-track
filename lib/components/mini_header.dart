import 'package:flutter/material.dart';

import 'colors.dart';

class MiniHeader extends StatelessWidget {
  final String title;
  const MiniHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: appPrimaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
