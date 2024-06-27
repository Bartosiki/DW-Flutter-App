import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:flutter/material.dart';

@immutable
class Config {
  final String mainColor;
  final String registrationLink;

  const Config({
    required this.mainColor,
    required this.registrationLink,
  });

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      mainColor: json[FirestoreConfigFields.mainColor],
      registrationLink: json[FirestoreConfigFields.registrationLink],
    );
  }
}
