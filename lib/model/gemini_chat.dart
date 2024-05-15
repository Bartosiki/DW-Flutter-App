import 'package:flutter/material.dart';

@immutable
class GeminiChat {
  final List<GeminiChatChunk> history;

  const GeminiChat({required this.history});

  factory GeminiChat.fromJson(Map<String, dynamic> json) {
    return GeminiChat(
      history: List<GeminiChatChunk>.from(
        json['history'].map(
          (x) => GeminiChatChunk.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'history': history.map((x) => x.toJson()).toList(),
    };
  }
}

@immutable
class GeminiChatChunk {
  final String role;
  final List<Part> parts;

  const GeminiChatChunk({required this.role, required this.parts});

  factory GeminiChatChunk.fromJson(Map<String, dynamic> json) {
    return GeminiChatChunk(
      role: json['role'],
      parts: List<Part>.from(
        json['parts'].map(
          (x) => Part.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'parts': parts.map((x) => x.toJson()).toList(),
    };
  }
}

@immutable
class Part {
  final String text;

  const Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
