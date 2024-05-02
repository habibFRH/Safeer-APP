// sign_up_page.dart

// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/customButtonAuth.dart';
import '../components/customLogoAuth.dart';
import '../components/textFormField.dart';
import 'auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _signUp(BuildContext context) async {
    try {
      await _authService.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Sign-up failed. Error: $e');

      String errorMessage = 'Sign-up failed. Please try again.';

      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'An error occurred during sign-up.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(errorMessage),
        ),
      );
    }
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
                const CustomLogoAuth(
                  height: 125,
                  width: 125,
                ),
                const Center(
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ),
                CustomTextForm(
                  label: "First Name",
                  hinttext: 'Enter Your First Name',
                  mycontroller: firstNameController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                ),
                CustomTextForm(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  label: "Last Name",
                  hinttext: 'Enter Your Last Name',
                  mycontroller: lastNameController,
                ),
                CustomTextForm(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  label: "Number",
                  hinttext: 'Enter Your Number',
                  mycontroller: phoneNumberController,
                ),
                CustomTextForm(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  label: "Email",
                  hinttext: 'Enter Your Email',
                  mycontroller: emailController,
                ),
                CustomTextForm(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  label: "Password",
                  hinttext: 'Enter Your Password',
                  mycontroller: passwordController,
                ),
              ],
            ),
            CustomButtonAuth(
              title: "SignUp",
              onPressed: () => _signUp(context),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Already have an account ? "),
                      TextSpan(
                        text: "Login",
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
