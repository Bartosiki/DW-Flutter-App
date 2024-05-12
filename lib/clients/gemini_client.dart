import 'dart:convert';

import 'package:dw_flutter_app/model/gemini_chat.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class GeminiClient {
  final Uri geminiEndpoint;

  GeminiClient()
      : geminiEndpoint =
            Uri.parse('http://10.0.2.2:5001/dw-flutter-app/us-central1/gemini'),
        super();

  Future<String> generateAssistantResponse(String userText) async {
    try {
      final GeminiChat chatHistory = GeminiChat(history: [
        GeminiChatChunk(role: 'user', parts: [Part(text: userText)]),
      ]);
      final geminiResponse =
          await http.post(geminiEndpoint, body: jsonEncode(chatHistory));
      return geminiResponse.body;
    } catch (error) {
      return "There was an error. Please try again later.";
    }
  }
}
