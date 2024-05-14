import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventCard extends StatelessWidget {
  EventCard({
    super.key,
    required this.title,
    required this.partner,
    required this.time,
    required this.room,
  });

  final String title;
  final String partner;
  final DateTime time;
  final String room;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3.0,
      ),
      child: Card(
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
                softWrap: true,
              ),
            ),
            subtitle: Text(
              partner,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Color.fromRGBO(255, 255, 255, 0.5),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Text(
                  room,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
