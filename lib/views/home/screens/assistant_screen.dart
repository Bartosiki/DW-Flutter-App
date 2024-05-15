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
        onSendPressed: (partialText) =>
            ref.read(messagesProvider.notifier).handleSendPressed(partialText),
        messages: messages,
        user: ref.watch(userProvider),
      ),
    );
  }
}
