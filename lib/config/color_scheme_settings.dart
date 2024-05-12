import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorSchemeSettings {
  static const String _isDarkModeKey = 'is_dark_mode';

  static Future<bool> isDarkModeEnabled(Brightness initialBrightness) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_isDarkModeKey) ??
        initialBrightness == Brightness.dark;
  }

  static Future<void> setDarkModeEnabled(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isDarkModeKey, value);
  }
}
