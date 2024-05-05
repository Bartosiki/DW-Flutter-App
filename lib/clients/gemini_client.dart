import 'package:dw_flutter_app/clients/vertex_http_client.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiClient {
  final GenerativeModel _client;

  GeminiClient({
    required String apiKey,
    required String projectUrl,
  }) : _client = GenerativeModel(
          model: 'gemini-pro',
          apiKey: apiKey,
          httpClient: VertexHttpClient(projectUrl),
        );

  Future<String?> generateTestResponse() async {
    final content = [Content.text("Hey Gemini, say hi to me!")];
    final response = await _client.generateContent(content);

    print(response.text);

    return response.text;
  }
}
