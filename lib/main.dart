import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:dw_flutter_app/views/home/home_view.dart';
import 'package:dw_flutter_app/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'auth/provider/is_logged_in_provider.dart';
import 'clients/vertex_http_client.dart';
import 'firebase_options.dart';

import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  const apiKey = String.fromEnvironment('API_KEY');
  const projectUrl = String.fromEnvironment('VERTEX_AI_PROJECT_URL');

  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: apiKey,
    httpClient: VertexHttpClient(projectUrl),
  );

  const prompt = 'Write a story about a magic backpack.';
  final content = [Content.text(prompt)];
  final response = await model.generateContent(content);

  print(response.text);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final isLoggedIn = ref.watch(isLoggedInProvider);
            return isLoggedIn ? const HomeView() : const LoginView();
          },
        ),
      ),
    );
  }
}
