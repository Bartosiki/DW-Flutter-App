import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/provider/language/language_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier(super.initialState);

  static Future<LanguageNotifier> create() async {
    final languageCode = await LanguageSettings.getCurrentLanguage();
    final defaultLanguageCode =
        LanguageSettings.getSystemLanguageCode() == 'pl' ? 'pl' : 'en';
    return LanguageNotifier(languageCode ?? defaultLanguageCode);
  }

  Future<void> setLanguage(String value) async {
    state = value;
    await LanguageSettings.setCurrentLanguage(value);
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, String>(
  (ref) {
    final languageNotifierFuture = ref.watch(languageNotifierProvider);
    final defaultLanguageCode =
        LanguageSettings.getSystemLanguageCode() == 'pl' ? 'pl' : 'en';
    return (languageNotifierFuture.value ??
        LanguageNotifier(defaultLanguageCode));
  },
);
