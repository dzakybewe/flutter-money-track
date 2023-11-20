import 'package:flutter/material.dart';
import '../components/mini_header.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MiniHeader(title: 'Profile',),
      ],
    );
  }
}
