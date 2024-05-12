class GeminiClient {
  final String apiKey;
  final String projectUrl;

  GeminiClient({required this.apiKey, required this.projectUrl});

  Future<String?> generateTestResponse() async {
    return 'Hello from GeminiClient';
  }
}
