import 'package:dw_flutter_app/screens/guest/only_for_logged_user.dart';
import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import '../../../provider/gemini/gemini_messages_provider.dart';

class AssistantScreen extends ConsumerWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(geminiMessagesProvider);
    final selectedLanguage = ref.watch(languageProvider);
    final strings = ref.watch(selectedStringsProvider);

    return OnlyForLoggedUserScreen(
      content: Scaffold(
        body: Chat(
          theme: DefaultChatTheme(
            backgroundColor: Theme.of(context).colorScheme.surface,
            inputBackgroundColor: Theme.of(context).colorScheme.primary,
            inputTextColor: Theme.of(context).colorScheme.onPrimary,
            dateDividerTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.w800,
              height: 1.333,
            ),
            emptyChatPlaceholderTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            inputSurfaceTintColor: Theme.of(context).colorScheme.secondary,
            primaryColor: Theme.of(context).colorScheme.primary,
            secondaryColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
            sentMessageBodyTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            receivedMessageBodyTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            receivedMessageCaptionTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.333,
            ),
            inputTextCursorColor: Theme.of(context).colorScheme.onPrimary,
          ),
          onSendPressed: (partialText) => ref
              .read(geminiMessagesProvider.notifier)
              .handleSendPressed(partialText, strings.assistantError),
          l10n: selectedLanguage == LanguageSettings.defaultLanguage
              ? const ChatL10nEn()
              : const ChatL10nPl(),
          messages: messages,
          user: ref.watch(userProvider),
        ),
      ),
    );
  }
}
