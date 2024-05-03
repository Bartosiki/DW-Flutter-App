import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  TaskCard(
      {required this.title,
      required this.subtitle,
      required this.points,
      super.key});

  String title;
  String subtitle;
  int points;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Card(
            color: Colors.white10,
            child: ListTile(
              trailing: CircleAvatar(
                backgroundColor: Colors.white10,
                child: Text(
                  "$points",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(subtitle,
                  style: const TextStyle(
                      color: Colors.white60, fontWeight: FontWeight.normal)),
              textColor: Colors.white,
            )),
      ),
    );
  }
}
