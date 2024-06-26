import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:dw_flutter_app/model/gemini_chat.dart';
import 'package:dw_flutter_app/network/gemini_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class GeminiMessagesNotifier extends StateNotifier<List<Message>> {
  final Uuid uuid;
  final User user;
  final User assistant;
  final GeminiClient client;
  final String assistantWelcomeMessage;

  GeminiMessagesNotifier(this.uuid, this.user, this.assistant, this.client,
      this.assistantWelcomeMessage)
      : super([]) {
    _loadChatHistory(assistantWelcomeMessage);
  }

  void addMessage(Message message) {
    state = [message, ...state];
    _saveChatHistory();
  }

  Future<void> handleSendPressed(
      PartialText message, String assistantError) async {
    final wholeHistory = state;

    final userMessage = TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: uuid.v4(),
      text: message.text,
    );
    addMessage(userMessage);

    final lastAssistantMessage = wholeHistory.firstWhereOrNull(
      (element) => element.author == assistant,
    );
    final previousUserMessage = wholeHistory.firstWhereOrNull(
      (element) => element.author == user,
    );
    final previousAssistantMessage = wholeHistory.firstWhereOrNull(
      (element) =>
          element.author == assistant && element != lastAssistantMessage,
    );

    final previousAssistantMessageChunk = previousAssistantMessage != null
        ? GeminiChatChunk(
            role: previousAssistantMessage.author == assistant
                ? 'assistant'
                : 'user',
            parts: [
              Part(text: (previousAssistantMessage as TextMessage).text),
            ],
          )
        : null;
    final previousUserMessageChunk = previousUserMessage != null
        ? GeminiChatChunk(
            role: previousUserMessage.author == user ? 'user' : 'assistant',
            parts: [
              Part(text: (previousUserMessage as TextMessage).text),
            ],
          )
        : null;
    final lastAssistantMessageChunk = lastAssistantMessage != null
        ? GeminiChatChunk(
            role:
                lastAssistantMessage.author == assistant ? 'assistant' : 'user',
            parts: [
              Part(text: (lastAssistantMessage as TextMessage).text),
            ],
          )
        : null;

    final historyToSend = GeminiChat(
      history: [
        if (previousAssistantMessageChunk != null)
          previousAssistantMessageChunk,
        if (previousUserMessageChunk != null) previousUserMessageChunk,
        if (lastAssistantMessageChunk != null) lastAssistantMessageChunk,
        GeminiChatChunk(
          role: 'user',
          parts: [
            Part(text: message.text),
          ],
        )
      ],
    );

    String response =
        await client.generateAssistantResponse(historyToSend, assistantError);

    final assistantMessage = TextMessage(
      author: assistant,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: uuid.v4(),
      text: response,
    );
    addMessage(assistantMessage);
  }

  @override
  void dispose() async {
    await _saveChatHistory();
    super.dispose();
  }

  Future<void> _loadChatHistory(String assistantWelcomeMessage) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMessages = prefs.getString('chatHistory');

    if (encodedMessages != null && encodedMessages != '[]') {
      final decodedMessages = (jsonDecode(encodedMessages) as List)
          .map((x) => TextMessage.fromJson(x as Map<String, dynamic>))
          .toList();

      state = decodedMessages;
    } else {
      state = [_getWelcomeMessage(assistantWelcomeMessage)];
    }
  }

  Future<void> _saveChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMessages = jsonEncode(state);
    await prefs.setString('chatHistory', encodedMessages);
  }

  Future<void> clearChatHistory(String assistantWelcomeMessage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('chatHistory');
    state = [];
    _loadChatHistory(assistantWelcomeMessage);
  }

  Message _getWelcomeMessage(String assistantWelcomeMessage) {
    return TextMessage(
      author: assistant,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: uuid.v4(),
      text: assistantWelcomeMessage,
    );
  }
}
