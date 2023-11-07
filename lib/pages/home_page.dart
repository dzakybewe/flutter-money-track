import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/components/my_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Authentication().currentUser;

  Future<void> signOut() async {
    await Authentication().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return MyButton(
      onTap: signOut,
      text: 'Sign Out',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _userUid(),
            _signOutButton()
          ],
        )
      ),
    );
  }
}
