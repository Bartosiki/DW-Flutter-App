import 'package:dw_flutter_app/components/tasks/standings_info_card.dart';
import 'package:flutter/material.dart';

class StandingsInfoCardRow extends StatelessWidget {
  StandingsInfoCardRow(
      {super.key,
      required this.timeLeft,
      required this.position,});

  String timeLeft;
  String position;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StandingsInfoCard(
            title: timeLeft,
            subtitle: 'TIME LEFT',
        ),
        const SizedBox(width: 24),
        StandingsInfoCard(
            title: position,
            subtitle: 'YOUR PLACE',
        ),
      ],
    );
  }
}