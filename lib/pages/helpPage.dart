// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to RegistreCom Mobile!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'How to Use the App:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Submit a Request:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - Click on "Submit a Request" from the home screen.',
            ),
            Text(
              '   - Fill in the required information in the form.',
            ),
            Text(
              '   - Review and submit the request.',
            ),
            SizedBox(height: 8),
            Text(
              '2. Track a Request:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - Click on "Track a Request" from the home screen.',
            ),
            Text(
              '   - View the status and updates of your submitted requests.',
            ),
            SizedBox(height: 16),
            Text(
              'Need Assistance?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions or encounter issues, feel free to contact our support team.',
            ),
            Text(
              '   - Email: support@registrecommobile.com',
            ),
            Text(
              '   - Phone: +1 (123) 456-7890',
            ),
          ],
        ),
      ),
    );
  }
}
