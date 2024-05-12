import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/app_colors.dart';

class EventCard extends StatelessWidget {
  EventCard(
      {super.key,
      required this.eventTitle,
      required this.partner,
      required this.time,
      required this.room});

  final String eventTitle;
  final String partner;
  final DateTime time;
  final String room;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Card(
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                eventTitle,
                style: const TextStyle(
                  fontSize: 16,
                ),
                softWrap: true,
              ),
              subtitle: Text(
                partner,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color.fromRGBO(255, 255, 255, 0.5)),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${time.hour}:${time.minute}',
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
      ),
    );
  }
}
