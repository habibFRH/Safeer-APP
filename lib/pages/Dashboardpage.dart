import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best SIM Card:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildBestSimCard(),
            SizedBox(height: 20),
            Text(
              'Best Hotel:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildBestHotel(),
            SizedBox(height: 20),
            Text(
              'Best Fast Food:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildBestFastFood(),
          ],
        ),
      ),
    );
  }

  Widget _buildBestSimCard() {
    // Replace this with your logic to fetch and display best SIM card information
    return Text('Best SIM Card Data Here');
  }

  Widget _buildBestHotel() {
    // Replace this with your logic to fetch and display best hotel information
    return Text('Best Hotel Data Here');
  }

  Widget _buildBestFastFood() {
    // Replace this with your logic to fetch and display best fast food information
    return Text('Best Fast Food Data Here');
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Dashboard App',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: DashboardPage(),
  ));
}
