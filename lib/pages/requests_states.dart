// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/customListTile.dart';
import '../components/drawer.dart';

class RequestsState extends StatefulWidget {
  const RequestsState({Key? key});

  @override
  State<RequestsState> createState() => _RequestsStateState();
}

class _RequestsStateState extends State<RequestsState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Request States',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff5E17EB),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Request')
            .orderBy('request')
            .snapshots(),
        builder: (context, snapshot) {
          List<CustomListTile> requestWidgets = [];

          if (snapshot.hasData) {
            final requests = snapshot.data?.docs.reversed.toList();

            for (var request in requests!) {
              final requestWidget = CustomListTile(
                state: request['state'],
                title: request['request'],
              );
              requestWidgets.add(requestWidget);
            }
          }

          return Expanded(
            child: ListView(
              children: requestWidgets,
            ),
          );
        },
      ),
    );
  }
}
