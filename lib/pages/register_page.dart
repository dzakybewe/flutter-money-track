import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/auth/my_database.dart';
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
  // Text Editing Controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Register Method
  Future<void> createUserWithEmailAndPassword() async {
    showDialog(
        context: context,
        builder: (context)
        => const Center(
          child: CircularProgressIndicator(),
        )
    );

    if (passwordController.text != confirmPasswordController.text){
      // loading popup
      Navigator.pop(context);
      
      displayPopupMessage('Passwords don\'t match!', context);
    } else {
      try {
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
        if(context.mounted) return Navigator.pop(context);

        if(context.mounted) return displayPopupMessage(e.message!, context);
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
                  // Logo
                  const Icon(
                    Icons.attach_money,
                    size: 80,
                  ),

                  const SizedBox(height: 20,),

                  // Welcome Text
                  const Text(
                      'M o n e y T r a c k',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900
                      )
                  ),

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
