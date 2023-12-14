import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/components/colors.dart';
import 'package:flutter_money_track/components/my_button.dart';
import 'package:flutter_money_track/components/my_text_field.dart';
import 'package:flutter_money_track/supportwidgets/support_widgets_functions.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onPressed;

  const RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Register Method
  Future<void> createUserWithEmailAndPassword() async {

    try {
      if (context.mounted) {
        if (usernameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) return displayPopupMessage('Please fill in the blanks', context);
        if (passwordController.text != confirmPasswordController.text) return displayPopupMessage('Passwords don\'t match', context);
      }

      UserCredential userCredential = await Authentication().createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      /// add user to firestore
      MyDatabase().addNewUserToDb(
          userCredential,
          usernameController.text
      );
    } on FirebaseAuthException catch(e) {
      if (context.mounted) {
        if (e.message == 'The email address is already in use by another account.'){
          return displayPopupMessage('Email address has already been used', context);
        }
        return displayPopupMessage(e.message!, context);
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                  Image.asset('images/logo_moneytrack.png', width: 298, height: 55,),

                  const SizedBox(height: 50),

                  // Username Field
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                    inputType: TextInputType.text,
                  ),

                  const SizedBox(height: 15),

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

                  const SizedBox(height: 15),

                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    inputType: TextInputType.text,
                  ),

                  const SizedBox(height: 20),

                  // Login Button
                  MyButton(
                      text: 'Register',
                      onTap: createUserWithEmailAndPassword
                  ),

                  // Don't have an account, register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      TextButton(
                        onPressed: widget.onPressed,
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero
                        ),
                        child: const Text(
                          'Login here',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appSecondary
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
