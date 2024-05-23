import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSettings {
  static const String _languageModeKey = 'language_mode';
  static const String defaultLanguage = 'en';

  static String getSystemLanguageCode() {
    return PlatformDispatcher.instance.locale.languageCode;
  }

  static Future<String?> getCurrentLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_languageModeKey);
  }

  static Future<void> setCurrentLanguage(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageModeKey, value);
  }
}
