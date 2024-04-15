import 'package:dw_flutter_app/extensions/remove_all.dart';
import 'package:flutter/material.dart';

extension HtmlColorToColor on String {
  Color toColor() {
    final hexColor = removeAll(['0x', '#']);
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
