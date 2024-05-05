import 'package:dw_flutter_app/clients/vertex_http_client.dart';

class GeminiClient {
  final VertexHttpClient _client;

  GeminiClient(this._client);

  Future<String> fetch(String path) async {
    final response = await _client.get(Uri.parse('$_baseUrl$path'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch data');
    }
    return response.body;
  }
}
