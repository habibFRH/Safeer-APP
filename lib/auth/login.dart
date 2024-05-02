// login_page.dart

// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/customButtonAuth.dart';
import '../components/customLogoAuth.dart';
import '../components/textFormField.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _signIn(BuildContext context) async {
    try {
      await _authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Login failed. Error: $e');

      String errorMessage = 'Login failed. Check your credentials.';

      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'An error occurred during login.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red, // Set the background color to red
        ),
      );
    }
  }

  void _goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/sign_up');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(92, 255, 255, 255), Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.topCenter,
          ),
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomLogoAuth(height: 200, width: 200),
                Container(
                  height: 65,
                ),
                const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 30,
                ),
                CustomTextForm(
                  obscureText: false,
                  label: "Email",
                  hinttext: 'Enter Your Email',
                  mycontroller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextForm(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  label: "Password",
                  hinttext: 'Enter Your Password',
                  mycontroller: passwordController,
                ),
              ],
            ),
            CustomButtonAuth(
              title: "Login",
              onPressed: () => _signIn(context),
            ),
            Container(
              height: 60,
            ),
            InkWell(
              onTap: () => _goToSignUp(context),
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "don't have an account ? "),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          color: Color.fromARGB(255, 18, 194, 135),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
