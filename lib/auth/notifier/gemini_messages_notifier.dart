import 'dart:convert';
import 'package:dw_flutter_app/clients/gemini_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class MessagesNotifier extends StateNotifier<List<Message>> {
  final Uuid uuid;
  final User user;
  final User assistant;
  final GeminiClient client;

  MessagesNotifier(this.uuid, this.user, this.assistant, this.client)
      : super([]) {
    _loadChatHistory();
  }

  void addMessage(Message message) {
    state = [message, ...state];
  }

  Future<void> handleSendPressed(PartialText message) async {
    final userMessage = TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: uuid.v4(),
      text: message.text,
    );
    addMessage(userMessage);

    String response = await client.generateAssistantResponse(message.text);

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

  Future<void> _loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMessages = prefs.getString('chatHistory');

    if (encodedMessages != null) {
      final decodedMessages = (jsonDecode(encodedMessages) as List)
          .map((x) => TextMessage.fromJson(x as Map<String, dynamic>))
          .toList();

      state = decodedMessages;
    }
  }

  Future<void> _saveChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMessages = jsonEncode(state);
    await prefs.setString('chatHistory', encodedMessages);
  }
}
