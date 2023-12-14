import 'package:flutter/material.dart';
import 'colors.dart';

class MiniHeader extends StatelessWidget {
  final String title;
  final bool backIcon;
  final bool rightIcon;
  const MiniHeader({super.key, required this.title, required this.backIcon, required this.rightIcon,});

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
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
            ),
            if (backIcon)
              Positioned.directional(
                textDirection: TextDirection.ltr,
                start: 12,
                top: 1,
                bottom: 1,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 24,
                  color: Colors.white,
                  alignment: AlignmentDirectional.center,
                ),
              ),
            if (rightIcon)
              Positioned.directional(
                textDirection: TextDirection.rtl,
                start: 12,
                top: 1,
                bottom: 1,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                  iconSize: 24,
                  color: Colors.red,
                  alignment: AlignmentDirectional.center,
                ),
              ),
          ]
        )
      )
    );
  }
}
