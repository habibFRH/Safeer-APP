// customLogoAuth.dart

// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomLogoAuth extends StatelessWidget {
  final double height;
  final double width;

  const CustomLogoAuth({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          "images/2.png",
          fit: BoxFit.fitWidth,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
