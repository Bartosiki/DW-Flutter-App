import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class StandingsInfoCard extends StatelessWidget {
  StandingsInfoCard({super.key, required this.infoCardWidth, required this.title, required this.subtitle});

  double infoCardWidth;
  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: infoCardWidth,
      decoration: BoxDecoration(
        color: AppColors.standingsCardForegroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}