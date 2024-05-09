import 'package:flutter/material.dart';
import 'package:safeer/components/drawer.dart';
import 'package:safeer/components/hotellisttile.dart';

class HotelsPage extends StatefulWidget {
  @override
  _HotelsPageState createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  String selectedCountry = 'All'; // Default value for country dropdown
  String selectedPriceRange = 'Any'; // Default value for price range dropdown

final Map<String, List<Map<String, dynamic>>> countriesWithHotels = {
  'All': [
    {
      'name': 'Sheraton Hotel',
      'address': '123 Main Street, City A',
      'price': 100,
      'currency': '\$',
    },
    {
      'name': 'Hilton Garden Inn',
      'address': '456 Elm Street, City B',
      'price': 150,
      'currency': '\$',
    },
    {
      'name': 'Marriott Courtyard',
      'address': '789 Oak Street, City C',
      'price': 120,
      'currency': '\$',
    },
    {
      'name': 'Paris Marriott Champs Elysees Hotel',
      'address': '123 Rue Principale, Ville D',
      'price': 200,
      'currency': '€',
    },
    {
      'name': 'Hôtel Plaza Athénée',
      'address': '456 Rue des Roses, Ville E',
      'price': 180,
      'currency': '€',
    },
    {
      'name': 'The Peninsula Paris',
      'address': '789 Rue du Moulin, Ville F',
      'price': 220,
      'currency': '€',
    },
    {
      'name': 'New York Marriott Marquis',
      'address': '123 Street, City G',
      'price': 80,
      'currency': '\$',
    },
    {
      'name': 'The Ritz-Carlton New York, Central Park',
      'address': '456 Boulevard, City H',
      'price': 250,
      'currency': '\$',
    },
    {
      'name': 'Four Seasons Hotel New York Downtown',
      'address': '789 Avenue, City I',
      'price': 190,
      'currency': '\$',
    },
    {
      'name': 'The Langham, New York, Fifth Avenue',
      'address': '123 Street, City J',
      'price': 150,
      'currency': '€',
    },
    {
      'name': 'W New York - Times Square',
      'address': '456 Boulevard, City K',
      'price': 210,
      'currency': '€',
    },
    {
      'name': 'The Plaza Hotel',
      'address': '789 Avenue, City L',
      'price': 140,
      'currency': '€',
    },
    {
      'name': 'Tokyo Marriott Hotel',
      'address': '1-1-1, Chiyoda, Tokyo',
      'price': 18000,
      'currency': '¥',
    },
    {
      'name': 'The Ritz-Carlton, Kyoto',
      'address': 'Kamogawa Nijo-Ohashi Hotori, Nakagyo Ward, Kyoto',
      'price': 35000,
      'currency': '¥',
    },
    {
      'name': 'The Peninsula Hong Kong',
      'address': 'Salisbury Rd, Tsim Sha Tsui, Hong Kong',
      'price': 3500,
      'currency': 'HK\$',
    },
  ],
  'USA': [
    {
      'name': 'Sheraton Hotel',
      'address': '123 Main Street, City A',
      'price': 100,
      'currency': '\$',
    },
    {
      'name': 'Hilton Garden Inn',
      'address': '456 Elm Street, City B',
      'price': 150,
      'currency': '\$',
    },
    {
      'name': 'Marriott Courtyard',
      'address': '789 Oak Street, City C',
      'price': 120,
      'currency': '\$',
    },
    {
      'name': 'New York Marriott Marquis',
      'address': '123 Street, City G',
      'price': 80,
      'currency': '\$',
    },
    {
      'name': 'The Ritz-Carlton New York, Central Park',
      'address': '456 Boulevard, City H',
      'price': 250,
      'currency': '\$',
    },
    {
      'name': 'Four Seasons Hotel New York Downtown',
      'address': '789 Avenue, City I',
      'price': 190,
      'currency': '\$',
    },
  ],
  'France': [
    {
      'name': 'Paris Marriott Champs Elysees Hotel',
      'address': '123 Rue Principale, Ville D',
      'price': 200,
      'currency': '€',
    },
    {
      'name': 'Hôtel Plaza Athénée',
      'address': '456 Rue des Roses, Ville E',
      'price': 180,
      'currency': '€',
    },
    {
      'name': 'The Peninsula Paris',
      'address': '789 Rue du Moulin, Ville F',
      'price': 220,
      'currency': '€',
    },
    {
      'name': 'The Langham, New York, Fifth Avenue',
      'address': '123 Street, City J',
      'price': 150,
      'currency': '€',
    },
    {
      'name': 'W New York - Times Square',
      'address': '456 Boulevard, City K',
      'price': 210,
      'currency': '€',
    },
    {
      'name': 'The Plaza Hotel',
      'address': '789 Avenue, City L',
      'price': 140,
      'currency': '€',
    },
  ],
  'Japan': [
    {
      'name': 'Tokyo Marriott Hotel',
      'address': '1-1-1, Chiyoda, Tokyo',
      'price': 18000,
      'currency': '¥',
    },
    {
      'name': 'The Ritz-Carlton, Kyoto',
      'address': 'Kamogawa Nijo-Ohashi Hotori, Nakagyo Ward, Kyoto',
      'price': 35000,
      'currency': '¥',
    },
  ],
  'Hong Kong': [
    {
      'name': 'The Peninsula Hong Kong',
      'address': 'Salisbury Rd, Tsim Sha Tsui, Hong Kong',
      'price': 3500,
      'currency': 'HK\$',
    },
  ],
  // Add more countries and hotels as needed
};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Safeer Hotels',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0D6FE5),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: selectedCountry,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCountry = newValue!;
                    });
                  },
                  items: countriesWithHotels.keys.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedPriceRange,
                  onChanged: (newValue) {
                    setState(() {
                      selectedPriceRange = newValue!;
                    });
                  },
                  items: [
                    'Any',
                    '\$0 - \$100',
                    '\$101 - \$200',
                    '\$201 and above',
                  ].map((String priceRange) {
                    return DropdownMenuItem<String>(
                      value: priceRange,
                      child: Text(priceRange),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: countriesWithHotels[selectedCountry]!.length,
              itemBuilder: (context, index) {
                final hotel = countriesWithHotels[selectedCountry]![index];
                // Check if the hotel matches the selected price range
                if (selectedPriceRange != 'Any') {
                  final price = hotel['price'] as int;
                  if (!isHotelInPriceRange(selectedPriceRange, price)) {
                    return SizedBox.shrink(); // Hide the hotel if it doesn't match the selected price range
                  }
                }
                return CustomListTile(
                  state: hotel['price'].toString(),
                  title: hotel['name'],
                  subTitle: hotel['address'],
                  currency: hotel['currency'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to check if a hotel is in the selected price range
  bool isHotelInPriceRange(String priceRange, int price) {
    switch (priceRange) {
      case '\$0 - \$100':
        return price >= 0 && price <= 100;
      case '\$101 - \$200':
        return price >= 101 && price <= 200;
      case '\$201 and above':
        return price >= 201;
      default:
        return true; // Any price range, always return true
    }
  }
}
