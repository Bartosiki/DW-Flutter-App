import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedStringsProvider = Provider<Strings>((ref) {
  final selectedLanguage = ref.watch(languageProvider);
  return selectedLanguage == LanguageSettings.defaultLanguage
      ? StringsEn.en
      : StringsPl.pl;
});
