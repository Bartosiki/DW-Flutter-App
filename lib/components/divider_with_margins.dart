import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class DividerWithMargins extends StatelessWidget {
  const DividerWithMargins({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.dividerColor,
      thickness: 1.5,
    );
  }
}
