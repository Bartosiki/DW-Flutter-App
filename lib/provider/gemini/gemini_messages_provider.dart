import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/network/gemini_client.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:uuid/uuid.dart';
import 'gemini_messages_notifier.dart';

final uuidProvider = Provider((_) => const Uuid());
final userProvider = Provider((_) => const User(id: '1'));
final assistantProvider = Provider((_) => const User(id: '2'));
final geminiClientProvider = Provider((_) => GeminiClient());

final geminiMessagesProvider =
    StateNotifierProvider.autoDispose<GeminiMessagesNotifier, List<Message>>(
  (ref) {
    final selectedLanguage = ref.watch(languageProvider);
    final strings = selectedLanguage == LanguageSettings.defaultLanguage
        ? StringsEn.en
        : StringsPl.pl;

    return GeminiMessagesNotifier(
      ref.watch(uuidProvider),
      ref.watch(userProvider),
      ref.watch(assistantProvider),
      ref.watch(geminiClientProvider),
      strings.assistantWelcomeMessage,
    );
  },
);
