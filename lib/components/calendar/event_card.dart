import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/app_colors.dart';

class EventCard extends StatelessWidget {
  EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.standingsCardForegroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.transparent,
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
              )
            ]),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "W jaki sposób AI zmienia rzeczywistość?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "Accenture",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "11:00",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "Aula E1",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
