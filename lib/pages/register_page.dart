import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/my_button.dart';
import 'package:flutter_money_track/components/my_text_field.dart';

class RegisterPage extends StatelessWidget {
  // Text Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final void Function()? onPressed;

  RegisterPage({super.key, required this.onPressed});

  // Login Method
  void register(){

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

                  // Email Field
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 15),

                  // Password Field
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  MyTextField(
                    controller: passwordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),

                  // Login Button
                  MyButton(
                      text: 'Register',
                      onTap: register
                  ),


                  // Don't have an account, register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      TextButton(
                        onPressed: onPressed,
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
