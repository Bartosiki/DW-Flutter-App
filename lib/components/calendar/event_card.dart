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
  final String time;
  final String room;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Card(
          color: Colors.white10,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                'W jaki sposób AI zmienia rzeczywistość?',
                style: TextStyle(
                  fontSize: 16,
                ),
                softWrap: true,
              ),
              subtitle: Text(
                'Accenture',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color.fromRGBO(255, 255, 255, 0.5)),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '11:00',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Aula E1',
                    style: TextStyle(
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
