import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safeer/components/drawer.dart';

class HotelsPage extends StatefulWidget {
  @override
  _HotelsPageState createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  List<Map<String, dynamic>> hotels = [];
  Position? currentPosition;
  List<Map<String, dynamic>> nearestHotels = [];
  List<Map<String, dynamic>> searchedHotels = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHotels();
  }

  // Load hotels from JSON file
  Future<void> _loadHotels() async {
    String data = await rootBundle.loadString('data/hotels.json');
    List<dynamic> jsonData = json.decode(data);
    hotels = jsonData.map((hotel) => hotel as Map<String, dynamic>).toList();
  }

  // Get the current geolocation and find nearest hotels
  Future<void> _findNearestHotels() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        nearestHotels = [];
      });
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        nearestHotels = [];
      });
      return;
    }

    currentPosition = await Geolocator.getCurrentPosition();

    if (currentPosition != null) {
      // Calculate distances and sort the hotels by distance from the current location
      hotels.sort((a, b) {
        double distanceA = Geolocator.distanceBetween(
          currentPosition!.latitude,
          currentPosition!.longitude,
          a['geo']['lat'],
          a['geo']['lon'],
        );

        double distanceB = Geolocator.distanceBetween(
          currentPosition!.latitude,
          currentPosition!.longitude,
          b['geo']['lat'],
          b['geo']['lon'],
        );

        return distanceA.compareTo(distanceB);
      });

      setState(() {
        nearestHotels = hotels.take(10).toList();
      });
    }
  }

  // Filter hotels by name
  void _searchHotels(String query) {
    setState(() {
      searchedHotels = hotels
          .where((hotel) =>
              hotel['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      isSearching = true;
    });
  }

  // Navigate to hotel details page
  void _navigateToHotelDetails(Map<String, dynamic> hotel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelDetailsPage(hotel: hotel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Hotels',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff5E17EB),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await _findNearestHotels();
            },
            child: Text('Find Nearest Hotels'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: (isSearching ? searchedHotels : nearestHotels).isEmpty
                ? Center(child: Text('No nearby hotels found.'))
                : ListView.builder(
                    itemCount: isSearching
                        ? searchedHotels.length
                        : nearestHotels.length,
                    itemBuilder: (context, index) {
                      final hotel = isSearching
                          ? searchedHotels[index]
                          : nearestHotels[index];
                      double distance = Geolocator.distanceBetween(
                        currentPosition!.latitude,
                        currentPosition!.longitude,
                        hotel['geo']['lat'],
                        hotel['geo']['lon'],
                      );

                      return Card(
                        child: ListTile(
                          title: Text(hotel['name']),
                          subtitle: Text(
                            'Distance: ${(distance / 1000).toStringAsFixed(2)} km\nAddress: ${hotel['address']}',
                          ),
                          onTap: () {
                            _navigateToHotelDetails(hotel);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isSearching = true;
          });
          showSearchDialog(context);
        },
        child: Icon(Icons.search),
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search Hotel'),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Enter hotel name',
            ),
            onChanged: _searchHotels,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class HotelDetailsPage extends StatefulWidget {
  final Map<String, dynamic> hotel;

  HotelDetailsPage({required this.hotel});

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  bool bookingStatus = false; // State variable to track booking status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotel['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.hotel['name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Address: ${widget.hotel['address']}'),
            SizedBox(height: 8),
            Text('Phone: ${widget.hotel['phone']}'),
            SizedBox(height: 8),
            Text('Website: ${widget.hotel['url']}'),
            SizedBox(height: 8),
            Text('Details: ${widget.hotel['content']}'),
            SizedBox(height: 8),
            Text('Details: ${widget.hotel['price']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  bookingStatus = true; // Set booking status to true
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Room has been booked!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Book Room'),
              style: ElevatedButton.styleFrom(
                primary: bookingStatus
                    ? Colors.green
                    : Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
