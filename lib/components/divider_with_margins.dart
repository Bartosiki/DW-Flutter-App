import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class DividerWithMargins extends StatelessWidget {
  const DividerWithMargins({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(
        children: [
          Divider(
            color: AppColors.dividerColor,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
