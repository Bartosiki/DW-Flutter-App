import 'dart:math';

import 'package:dw_flutter_app/clients/gemini_client.dart';
import 'package:dw_flutter_app/clients/vertex_http_client.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'dart:convert';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  final List<types.Message> _messages = [
    types.TextMessage(
      id: '1',
      author: types.User(id: '1'),
      text: 'Write a story about a magic backpack.',
    ),
  ];
  final _user = const types.User(id: '1');
  final _assistant = const types.User(id: '2');

  GeminiClient client;

  String geminiResponse = '';

  _AssistantScreenState() : client = GeminiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Chat(
      onSendPressed: _handleSendPressed,
      messages: _messages,
      user: _user,
    ));
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () async {
    //     String response = await client.generateTestResponse() ?? '';
    //     setState(() {
    //       geminiResponse = response;
    //     });
    //   },
    //   child: const Icon(Icons.send),
    // ));
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
      id: randomString(),
      text: message.text,
    );
    _addMessage(userMessage);

    String response = await client.generateTestResponse(message.text) ?? '';

    final assistantMessage = types.TextMessage(
      author: _assistant,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: response,
    );
    _addMessage(assistantMessage);
  }
}
