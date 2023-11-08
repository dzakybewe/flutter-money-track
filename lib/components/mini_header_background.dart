import 'package:flutter/material.dart';

import 'colors.dart';

class MiniHeaderBackground extends StatelessWidget {
  const MiniHeaderBackground({super.key});

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
    );
  }
}
