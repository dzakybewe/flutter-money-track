import 'package:flutter/material.dart';
import 'package:flutter_money_track/pages/login_page.dart';
import 'package:flutter_money_track/pages/register_page.dart';

class PageSetter extends StatefulWidget {
  const PageSetter({super.key});

  @override
  State<PageSetter> createState() => _PageSetterState();
}

class _PageSetterState extends State<PageSetter> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void toggleLoginRegister(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onPressed: toggleLoginRegister);
    } else {
      return RegisterPage(onPressed: toggleLoginRegister);
    }
  }
}
