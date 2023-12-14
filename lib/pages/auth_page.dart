import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/auth/page_setter.dart';

import 'base_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Authentication().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const BasePage();
        } else {
          return const PageSetter();
        }
      },
    );
  }
}
