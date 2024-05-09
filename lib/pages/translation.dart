import 'package:flutter/material.dart';
import 'package:safeer/components/drawer.dart';
import 'package:translator/translator.dart'; // Import the translator package

class Trdusctionpage extends StatefulWidget {
  const Trdusctionpage({Key? key}) : super(key: key);

  @override
  State<Trdusctionpage> createState() => _TrdusctionpageState();
}

class _TrdusctionpageState extends State<Trdusctionpage> {
  String translated = 'Translation';
  final translator = GoogleTranslator(); // Initialize the translator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Safeer Translation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0D6FE5),
      ),
      body: Card(
        margin: const EdgeInsets.all(12),
        child: ListView(
          children: [
            const Text(
              'English (US)',
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(hintText: "Enter Text"),
              onChanged: (text) async {
                final translation = await translator.translate(text, from: 'auto', to: 'es');
                setState(() {
                  translated = translation.text;
                });
              },
            ),
            const Divider(
              height: 32,
            ),
            Text(
              translated,
              style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            )
          ],
        ),
      ),
    );
  }
}
