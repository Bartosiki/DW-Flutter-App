import 'dart:convert';

import 'package:dw_flutter_app/network/authenticator.dart';
import 'package:dw_flutter_app/model/gemini_chat.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiClient {
  final Uri? geminiEndpoint;
  final Authenticator _authenticator;

  GeminiClient()
      : geminiEndpoint = Uri.tryParse(dotenv.get('GEMINI_ENDPOINT')),
        _authenticator = const Authenticator(),
        super();

  Future<String> generateAssistantResponse(
      GeminiChat chatHistory, String assistantError) async {
    if (geminiEndpoint == null) {
      return assistantError;
    }

    try {
      final userIdToken = await _authenticator.userIdToken;

      final geminiResponse = await http.post(
        geminiEndpoint!,
        body: jsonEncode(chatHistory),
        headers: {
          'Authorization': 'Bearer $userIdToken',
        },
      );

      return geminiResponse.body;
    } catch (error) {
      return assistantError;
    }
  }
}
