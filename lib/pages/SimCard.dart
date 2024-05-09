import 'package:flutter/material.dart';
import 'package:safeer/components/drawer.dart';
import 'package:safeer/pages/add_request.dart';

class SimCardPage extends StatelessWidget {
  const SimCardPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Safeer Sim Card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0D6FE5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ListTile(
                leading: Icon(Icons.sim_card),
                title: Text('Global SIM Card'),
                subtitle: Text('Stay connected around the world'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRequest(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Buy SIM Card'),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  _showSimCardInfoDrawer(context);
                },
                icon: const Icon(Icons.info),
                label: const Text('More Information'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSimCardInfoDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SIM Card Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Stay connected wherever you go with a global SIM card. Features include:',
              ),
              const SizedBox(height: 8),
              const Text(
                '- Works in over 190 countries\n'
                '- Pay-as-you-go data plans\n'
                '- Low-cost calling and messaging\n'
                '- Easy activation and setup',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}


