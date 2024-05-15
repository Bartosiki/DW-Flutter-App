import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';

class StandingsCard extends StatelessWidget {
  const StandingsCard({
    super.key,
    required this.rankIndex,
    required this.points,
    required this.name,
  });

  final int rankIndex;
  final int points;
  final String name;

  Color getCardBorderColor() {
    return (switch (rankIndex) {
      1 => Colors.yellow,
      2 => Colors.white54,
      3 => Colors.brown,
      int() => Colors.transparent,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: getCardBorderColor(),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: getCardBorderColor(),
            offset: const Offset(2.0, 2.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#$rankIndex  $name',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Column(
              children: [
                Text(
                  "$points",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                  ),
                ),
                Text(
                  Strings.standingsCardPoints,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
