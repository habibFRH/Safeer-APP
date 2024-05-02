import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:safeer/components/drawer.dart';
import 'package:safeer/pages/HotelsPage.dart';
import 'package:safeer/pages/QRcode.dart';
import 'package:safeer/pages/chips.dart';
import 'package:safeer/pages/requests_states.dart';
import 'package:safeer/pages/SimCard.dart';
import './auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  int index = 0;
  final items = [
    const Icon(
      Icons.home,
      color: Colors.white,
    ),
    const Icon(
      Icons.add,
      color: Colors.white,
    ),
    const Icon(
      Icons.task_alt_sharp,
      color: Colors.white,
    ),
    const Icon(
      Icons.task_alt_sharp,
      color: Colors.white,
    ),
    const Icon(
      Icons.food_bank_outlined,
      color: Colors.white,
    ),
  ];
  final screens = [
    const RequestsState(),
    const SimCardPage(),
    const NetworkChipsPage(),
    const BarcodeScannerPage(),
    // AirportsPage(),
    HotelsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        height: 53,
        onTap: (index) => setState(() {
          this.index = index;
        }),
        index: index,
        items: items,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        color: const Color.fromARGB(255, 18, 194, 135),
      ),
    );
  }
}
