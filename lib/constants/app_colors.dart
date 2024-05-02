import 'package:dw_flutter_app/extensions/hex_string_color_to_color.dart';
import 'package:flutter/material.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#FDFDFD'.toColor();
  static const loginButtonTextColor = Colors.black;
  static final backgroundColor = '#181818'.toColor();
  static final loginAgreementTextColor = '#E7E7E7'.toColor();
  static const loginAgreementHighlightTextColor =
      Color.fromARGB(255, 253, 253, 253);
  static final dividerColor = '#FDFDFD'.toColor();
  static final navigationItemActiveColor = Colors.amber[800]!;
  const AppColors._();
}
