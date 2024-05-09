import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String state;
  final String title;
  final String subTitle;
  final String currency;

  const CustomListTile(
      {super.key,
      required this.state,
      required this.title,
      required this.subTitle,
      required this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: const Icon(
          Icons.star_border,
          color: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subTitle,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          height: 40,
          child: Center(
            child: Text(
              state + " " + currency,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
