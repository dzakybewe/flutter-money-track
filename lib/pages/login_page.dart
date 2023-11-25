import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/my_button.dart';
import 'package:flutter_money_track/components/my_text_field.dart';

import '../auth/authentication.dart';
import '../supportwidgets/support_widgets_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;

  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Login Method
  Future<void> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await Authentication().signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
    } on FirebaseAuthException catch(e) {
      if (context.mounted) return displayPopupMessage(e.message!, context);
      if (context.mounted) return Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  const Icon(
                    Icons.attach_money,
                    size: 80,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Welcome Text
                  const Text('M o n e y T r a c k',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),

                  const SizedBox(height: 50),

                  // Email Field
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    inputType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 15),

                  // Password Field
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    inputType: TextInputType.text,
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('Forgot Password')],
                  ),

                  const SizedBox(height: 20),

                  // Login Button
                  MyButton(
                      text: 'LOGIN',
                      onTap: signInWithEmailAndPassword
                  ),

                  // Don't have an account, register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont have an account? '),
                      TextButton(
                        onPressed: widget.onPressed,
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text(
                          'Register here',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
