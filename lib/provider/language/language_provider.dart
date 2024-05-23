import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageNotifierProvider = FutureProvider<LanguageNotifier>(
  (ref) {
    return LanguageNotifier.create();
  },
);
