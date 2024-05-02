// ignore_for_file: sort_child_properties_last, deprecated_member_use, body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String state;
  final String title;
  CustomListTile({Key? key, required this.state, required this.title})
      : super(key: key);

  final colors = [
    Colors.orange[400],
    Colors.orange[100],
    Colors.red,
    Colors.red[100],
    Colors.green,
    Colors.green[100]
  ];

  final icons = [
    Icons.watch_later,
    Icons.cancel,
    Icons.verified_user_rounded,
    Icons.warning_amber_rounded
  ];

  IconData getIcon() {
    switch (state) {
      case 'Processing':
        return icons[0]; // Icons.watch_later
      case 'Rejected':
        return icons[1]; // Icons.cancel
      case 'Approved':
        return icons[2]; // Icons.verified_user_rounded
      default:
        return icons[3]; // Default to watch icon for unknown state
    }
  }

  Color? getColor() {
    switch (state) {
      case 'Processing':
        return colors[0]; // Colors.orange[100]
      case 'Rejected':
        return colors[2]; // Colors.red[100]
      case 'Approved':
        return colors[4]; // Colors.green[100]
    }
  }

  Color? getbgColor() {
    switch (state) {
      case 'Processing':
        return colors[1]; // Colors.orange[100]
      case 'Rejected':
        return colors[3]; // Colors.red[100]
      case 'Approved':
        return colors[5]; // Colors.green[100]
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Icon(
          getIcon(),
          color: getColor(),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
                  (state == "Approved" ||
                          state == "Rejected" ||
                          state == "Processing")
                  ? state
                  : "wrong",
              textScaleFactor: 2,
              style: TextStyle(
                color: getColor(),
                fontSize: 8,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: getbgColor(),
          ),
          height: 40,
        ),
      ),
    );
  }
}
