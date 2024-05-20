import 'package:dw_flutter_app/components/divider_with_margins.dart';
import 'package:dw_flutter_app/components/tasks/standings_card.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';

class SeparatedStanding extends StatelessWidget {
  const SeparatedStanding({
    super.key,
    required this.rankIndex,
    required this.points,
  });

  final int rankIndex, points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          const DividerWithMargins(),
          StandingsCard(
            rankIndex: rankIndex,
            points: points,
            isCurrentUser: true,
            name: Strings.you,
          ),
        ],
      ),
    );
  }
}
