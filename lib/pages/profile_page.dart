import 'package:flutter/material.dart';

import '../components/mini_header_background.dart';
import '../components/mini_header_content.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MiniHeaderBackground(),
        MiniHeaderContent(title: 'Profile'),
      ],
    );
  }
}
