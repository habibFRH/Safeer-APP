import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class AirportsPage extends StatefulWidget {
  @override
  _AirportsPageState createState() => _AirportsPageState();
}

class _AirportsPageState extends State<AirportsPage> {
  List<Map<String, dynamic>> airports = [];
  List<Map<String, dynamic>> filteredAirports = [];
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _loadAirports();
  }

  Future<void> _loadAirports() async {
    // Load airports data from JSON file
    String data = await rootBundle.loadString('data/airports.json');
    List<dynamic> jsonData = json.decode(data);
    airports = jsonData.map((airport) => airport as Map<String, dynamic>).toList();
    setState(() {
      filteredAirports = airports;
    });
  }

  Future<void> _getNearbyAirports() async {
    // Get current location
    currentPosition = await Geolocator.getCurrentPosition();

    if (currentPosition != null) {
      // Filter airports to find nearby airports within a certain distance
      setState(() {
        filteredAirports = airports.where((airport) {
          double distance = Geolocator.distanceBetween(
            currentPosition!.latitude,
            currentPosition!.longitude,
            airport['latitude'],
            airport['longitude'],
          );
          return distance <= 50000; // Customize the distance (in meters) as needed
        }).toList();
      });
    }
  }

  void _filterAirportsByName(String searchQuery) {
    // Filter airports based on the search query
    setState(() {
      filteredAirports = airports
          .where((airport) =>
              airport['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  void _showAirportSearchDrawer() {
    // Show search drawer for airport search
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search for an airport',
                  border: OutlineInputBorder(),
                ),
                onChanged: _filterAirportsByName,
              ),
            ],
          ),
        );
      },
      isScrollControlled: true, // Allow the drawer to appear in the middle of the screen
    );
  }

  void _bookFlight(int index) {
    // Book a flight for the selected airport
    setState(() {
      filteredAirports[index]['flightBooked'] = true;
    });

    // Show a SnackBar for booking confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Flight booked successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _getNearbyAirports,
            child: Text('Find Nearby Airports'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredAirports.length,
              itemBuilder: (context, index) {
                final airport = filteredAirports[index];
                return Card(
                  child: ListTile(
                    title: Text(airport['name']),
                    subtitle: Text(
                      'City: ${airport['city']} \nCountry: ${airport['country']}',
                    ),
                    trailing: airport.containsKey('flightBooked') && airport['flightBooked'] == true
                        ? ElevatedButton(
                            onPressed: null,
                            child: Text('Flight Booked'),
                            style: ElevatedButton.styleFrom(primary: Colors.green),
                          )
                        : ElevatedButton(
                            onPressed: () => _bookFlight(index),
                            child: Text('Book Flight'),
                          ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AirportDetailsPage(airport: airport),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAirportSearchDrawer,
        child: Icon(Icons.search),
      ),
    );
  }
}

class AirportDetailsPage extends StatefulWidget {
  final Map<String, dynamic> airport;

  AirportDetailsPage({required this.airport});

  @override
  _AirportDetailsPageState createState() => _AirportDetailsPageState();
}

class _AirportDetailsPageState extends State<AirportDetailsPage> {
  bool flightBooked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.airport['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.airport['name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('City: ${widget.airport['city']}'),
            SizedBox(height: 8),
            Text('Country: ${widget.airport['country']}'),
            SizedBox(height: 8),
            Text('IATA Code: ${widget.airport['iata_code']}'),
            SizedBox(height: 8),
            Text('ICAO Code: ${widget.airport['icao_code']}'),
            SizedBox(height: 8),
            Text('Coordinates: (${widget.airport['latitude']}, ${widget.airport['longitude']})'),
            SizedBox(height: 8),
            Text('Elevation: ${widget.airport['elevation']} meters'),
            SizedBox(height: 8),
            Text('Type: ${widget.airport['type']}'),
            SizedBox(height: 8),
            Text('Source: ${widget.airport['source']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  flightBooked = true;
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Flight booked successfully!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Book Flight'),
              style: ElevatedButton.styleFrom(
                primary: flightBooked ? Colors.green : Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
