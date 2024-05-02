// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import 'customLogoAuth.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(children: [
          const CustomLogoAuth(
            height: 150,
            width: 150,
          ),
          Container(
            height: 70,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/help_page');
              },
              leading: const Icon(
                Icons.help_center,
                color: Colors.black,
              ),
              title: const Text(
                "Help me",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/contactus_page');
              },
              leading: const Icon(
                Icons.contact_page,
                color: Colors.black,
              ),
              title: const Text(
                "Contact us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Card(
            color: Color.fromARGB(255, 255, 91, 79),
            child: ListTile(
              onTap: () async {
                await _authService.signOut();
                Navigator.pushNamed(context, '/');
              },
              leading: Icon(
                Icons.login_outlined,
                color: Colors.red[100],
              ),
              title: Text(
                "LOGOUT",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.red[100]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
