import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:flutter/material.dart';

@immutable
class Patron {
  final String name;
  final String imageSrc;

  const Patron({
    required this.name,
    required this.imageSrc,
  });

  factory Patron.fromJson(Map<String, dynamic> json) {
    return Patron(
      name: json[FirestorePatronsFields.name],
      imageSrc: json[FirestorePatronsFields.imageSrc],
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Patron &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            imageSrc == other.imageSrc;
  }

  @override
  int get hashCode => Object.hashAll(
        [
          name,
          imageSrc,
        ],
      );
}
