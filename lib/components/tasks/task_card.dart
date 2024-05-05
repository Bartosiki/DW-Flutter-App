import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {required this.title,
      required this.subtitle,
      required this.points,
      super.key,});

  final String title;
  final String subtitle;
  final int points;

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
                      color: Colors.white, fontWeight: FontWeight.bold
                  ),
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                ),
              ),
              subtitle: Text(subtitle,
                  style: const TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                      fontSize: 12
                  )
              ),
              textColor: Colors.white,
            ),
        ),
      ),
    );
  }
}
