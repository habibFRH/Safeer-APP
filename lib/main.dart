// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safeer/auth/login.dart';
import 'package:safeer/auth/sign_up_page.dart';
import 'package:safeer/home_page.dart';
import 'package:safeer/pages/HotelsPage.dart';
import 'package:safeer/pages/add_request.dart';
import 'package:safeer/pages/helpPage.dart';
import 'package:safeer/pages/SimCard.dart';
import 'pages/contactUs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyBlGTvFM-2Ap0EhI_88KHtKIrsUPnXov8M",
            appId: "1:154089837868:android:12cb7ebd8765c0ceb40889",
            messagingSenderId: "154089837868",
            projectId: "login1-1f923",
          ),
        )
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/sign_up': (context) => const SignUpPage(),
        '/help_page': (context) => const HelpPage(),
        '/Addrequest': (context) => const AddRequest(),
        '/contactus_page': (context) => const ContactUsPage(),
        '/simcard': (context) => const SimCardPage(),
        '/hotelspage': (context) => HotelsPage(),
      },
    );
  }
}
