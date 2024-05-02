// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  final String label;
  final String hinttext;
  final TextEditingController mycontroller;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextForm({
    Key? key,
    required this.label,
    required this.hinttext,
    required this.mycontroller,
    required this.keyboardType,
    required this.obscureText,
  }) : super(key: key);

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool isIconVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: widget.obscureText ? isIconVisible : false,
          keyboardType: widget.keyboardType,
          controller: widget.mycontroller,
          decoration: InputDecoration(
            hintText: " ${widget.hinttext}",
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 122, 122, 122),
              ),
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: isIconVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isIconVisible = !isIconVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
