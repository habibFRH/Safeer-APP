import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safeer/components/drawer.dart';
import 'package:safeer/pages/country.dart';

class NetworkChipsPage extends StatelessWidget {
  final String jsonData = '''
{
    "countries": [
      {
        "name": "USA",
        "network_chips": [
          {
            "name": "Verizon",
            "price": "\$50",
            "privileges": ["Unlimited calls", "5GB data"],
            "features": ["4G LTE support", "Nationwide coverage"]
          },
          {
            "name": "AT&T",
            "price": "\$45",
            "privileges": ["Unlimited calls", "10GB data"],
            "features": ["5G support", "International roaming"]
          }
        ]
      },
      {
        "name": "UK",
        "network_chips": [
          {
            "name": "EE",
            "price": "£30",
            "privileges": ["Unlimited calls", "3GB data"],
            "features": ["5G support", "Free EU roaming"]
          },
          {
            "name": "O2",
            "price": "£25",
            "privileges": ["Unlimited calls", "5GB data"],
            "features": ["4G LTE support", "Priority customer service"]
          }
        ]
      },
      {
        "name": "Germany",
        "network_chips": [
          {
            "name": "Telekom",
            "price": "€40",
            "privileges": ["Unlimited calls", "7GB data"],
            "features": ["5G support", "Free EU calls"]
          },
          {
            "name": "Vodafone",
            "price": "€35",
            "privileges": ["Unlimited calls", "10GB data"],
            "features": ["4G LTE support", "International roaming"]
          }
        ]
      }
    ]
  }''';

  const NetworkChipsPage({super.key});

  List<Country> _parseJson() {
    final parsedJson = jsonDecode(jsonData);
    final List<dynamic> countryList = parsedJson['countries'];
    return countryList.map((json) => Country.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Country> countries = _parseJson();

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Networdk Chips',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(94, 23, 235, 1),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          return ExpansionTile(
            title: Text(country.name),
            children: country.networkChips
                .map((chip) => ListTile(
                      title: Text(chip.name),
                      subtitle:
                          Text('${chip.price} - ${chip.features.join(', ')}'),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
