import 'dart:convert';

import 'package:dw_flutter_app/clients/gemini_client.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  final GeminiClient _client;
  final Uuid _uuid;
  final types.User _user;
  final types.User _assistant;
  List<types.Message> _messages;

  _AssistantScreenState()
      : _client = GeminiClient(),
        _messages = [],
        _user = const types.User(id: '1'),
        _assistant = const types.User(id: '2'),
        _uuid = const Uuid(),
        super();

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  @override
  void dispose() {
    _saveChatHistory(_messages);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        onSendPressed: _handleSendPressed,
        messages: _messages,
        user: _user,
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final userMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _uuid.v4(),
      text: message.text,
    );
    _addMessage(userMessage);

    String response = await _client.generateAssistantResponse(message.text);

    final assistantMessage = types.TextMessage(
      author: _assistant,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _uuid.v4(),
      text: response,
    );
    _addMessage(assistantMessage);
  }

  Future<void> _loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMessages = prefs.getString('chatHistory');
    if (encodedMessages != null) {
      final decodedMessages = jsonDecode(encodedMessages);
      print(decodedMessages);
      setState(() {
        _messages = decodedMessages
            .map((messageMap) => types.Message.fromJson(messageMap))
            .toList();
      });
    }
  }

  Future<void> _saveChatHistory(List<types.Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMessages = jsonEncode(messages);
    print(encodedMessages);
    await prefs.setString('chatHistory', encodedMessages);
  }
}
