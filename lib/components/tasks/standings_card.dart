import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';

class StandingsCard extends StatelessWidget {
  const StandingsCard({
    super.key,
    required this.rankIndex,
    required this.points,
    required this.isCurrentUser,
    required this.name,
  });

  final int rankIndex, points;
  final bool isCurrentUser;
  final String name;

  Color getCardBorderColor() {
    return (switch (rankIndex) {
      1 => Colors.yellow,
      2 => Colors.grey,
      3 => Colors.brown,
      int() => Colors.transparent,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: getCardBorderColor(),
            offset: const Offset(0.0, 2.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Card(
        color: isCurrentUser ? Theme.of(context).colorScheme.secondaryContainer : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: getCardBorderColor(),
            width: 2.0,
          ),
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
                isCurrentUser ? '#$rankIndex  You' : '#$rankIndex  $name',
                style: TextStyle(
                  fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Column(
                children: [
                  Text(
                    "$points",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    Strings.standingsCardPoints,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
