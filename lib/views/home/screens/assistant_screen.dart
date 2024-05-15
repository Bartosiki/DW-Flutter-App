import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import '../../../auth/provider/gemini_messages_provider.dart';

class AssistantScreen extends ConsumerWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesProvider);

    return Scaffold(
      body: Chat(
        theme: DefaultChatTheme(
          backgroundColor: Theme.of(context).colorScheme.background,
          inputBackgroundColor: Theme.of(context).colorScheme.secondary,
          inputTextColor: Theme.of(context).colorScheme.onSecondary,
          dateDividerTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w800,
            height: 1.333,
          ),
          emptyChatPlaceholderTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          inputSurfaceTintColor: Theme.of(context).colorScheme.secondary,
          primaryColor: Theme.of(context).colorScheme.primary,
          secondaryColor: Theme.of(context).colorScheme.primaryContainer,
          receivedMessageBodyTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          receivedMessageCaptionTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.333,
          ),
        ),
        onSendPressed: (partialText) =>
            ref.read(messagesProvider.notifier).handleSendPressed(partialText),
        messages: messages,
        user: ref.watch(userProvider),
      ),
    );
  }
}
