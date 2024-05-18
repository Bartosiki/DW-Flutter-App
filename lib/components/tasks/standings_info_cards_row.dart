import 'package:dw_flutter_app/components/tasks/standings_info_card.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';

class StandingsInfoCardRow extends StatelessWidget {
  const StandingsInfoCardRow({
    super.key,
    required this.timeLeft,
    required this.position,
  });

  final String timeLeft;
  final String position;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StandingsInfoCard(
          title: timeLeft,
          subtitle: Strings.timeLeft,
        ),
        const SizedBox(width: 24),
        StandingsInfoCard(
          title: position,
          subtitle: Strings.yourPlace,
        ),
      ],
    );
  }
}
