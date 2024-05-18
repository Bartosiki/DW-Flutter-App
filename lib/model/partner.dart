import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:flutter/material.dart';

@immutable
class Partner {
  final String name;
  final String imageSrc;
  final String package;

  const Partner({
    required this.name,
    required this.imageSrc,
    required this.package,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      name: json[FirestorePartnersFields.name],
      imageSrc: json[FirestorePartnersFields.imageSrc],
      package: json[FirestorePartnersFields.package],
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Partner &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            imageSrc == other.imageSrc &&
            package == other.package;
  }

  @override
  int get hashCode => Object.hashAll(
        [
          name,
          imageSrc,
          package,
        ],
      );
}

class PartnerPackage {
  static const standard = 'standard';
  static const silver = 'silver';
  static const gold = 'gold';
}
