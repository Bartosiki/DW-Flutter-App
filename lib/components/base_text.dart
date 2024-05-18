import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'link_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) {
    return BaseText(
      text: text,
      style: style,
    );
  }

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: AppColors.loginAgreementHighlightTextColor,
      fontWeight: FontWeight.bold,
    ),
  }) {
    return LinkText(
      text: text,
      onTapped: onTapped,
      style: style,
    );
  }
}
