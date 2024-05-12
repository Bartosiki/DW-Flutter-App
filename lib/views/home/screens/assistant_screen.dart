import 'package:dw_flutter_app/clients/gemini_client.dart';
import 'package:dw_flutter_app/clients/vertex_http_client.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  GeminiClient client;

  String geminiResponse = '';

  _AssistantScreenState() : client = GeminiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(geminiResponse),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String response = await client.generateTestResponse() ?? '';
            setState(() {
              geminiResponse = response;
            });
          },
          child: const Icon(Icons.send),
        ));
  }
}
