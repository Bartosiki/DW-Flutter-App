import 'dart:convert';

import 'package:dw_flutter_app/model/gemini_chat.dart';
import 'package:http/http.dart' as http;

class GeminiClient {
  final geminiEndpoint =
      Uri.parse('http://10.0.2.2:5001/dw-flutter-app/us-central1/gemini');

  GeminiClient();

  Future<String?> generateTestResponse() async {
    try {
      final GeminiChat chatHistory = GeminiChat(history: [
        GeminiChatChunk(
            role: 'user',
            parts: [Part(text: 'Write a story about a magic backpack.')]),
      ]);
      print(geminiEndpoint);
      print(jsonEncode(chatHistory));
      final geminiResponse =
          await http.post(geminiEndpoint, body: jsonEncode(chatHistory));
      return geminiResponse.body;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
