import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:flutter/material.dart';

@immutable
class Config {
  final String mainColor;

  const Config({
    required this.mainColor,
  });

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      mainColor: json[FirestoreConfigFields.mainColor],
    );
  }
}
