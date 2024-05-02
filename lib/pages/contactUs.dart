// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Information:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email: support@registrecommobile.com'),
              onTap: () => _launchEmail('support@registrecommobile.com'),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone: +1 (123) 456-7890'),
              onTap: () => _launchPhone('+11234567890'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Visit Us:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'RegistreCom Mobile Headquarters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('123 Main Street'),
            const Text('Cityville, State 12345'),
            const SizedBox(height: 16),
            const Text(
              'Have a Question or Feedback?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Feel free to reach out to us using the contact information above or submit the form below:',
            ),
            // Add a form or any additional UI components for user feedback.
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launch(emailLaunchUri.toString());
  }

Future<void> _launchPhone(String phoneNumber) async {
  final Uri phoneNumberLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(phoneNumberLaunchUri.toString());
}


}
