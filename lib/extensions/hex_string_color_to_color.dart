import 'package:dw_flutter_app/extensions/remove_all.dart';
import 'package:flutter/material.dart';

extension HtmlColorToColor on String {
  Color toColor() {
    final hexColor = removeAll(['0x', '#']);
    // Handle both 6-digit and 8-digit hex codes
    if (hexColor.length == 6) {
      return Color(int.parse('FF$hexColor', radix: 16));
    } else if (hexColor.length == 8) {
      return Color(int.parse(hexColor, radix: 16));
    }
    // Default fallback
    return Colors.black;
  }
}
