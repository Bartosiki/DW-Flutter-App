import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String? userId;
  final String displayName;
  final String email;
  final List<String> scannedQrCodes;
  final int gainedPoints;
  final bool isWinner;
  final Timestamp? lastScannedQrCodeTime;

  const User({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.scannedQrCodes,
    required this.gainedPoints,
    required this.isWinner,
    required this.lastScannedQrCodeTime,
  });

  factory User.unknown() {
    return const User(
      userId: null,
      displayName: '',
      email: '',
      scannedQrCodes: [],
      gainedPoints: 0,
      isWinner: false,
      lastScannedQrCodeTime: null,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json[FirestoreUsersFields.userId],
      displayName: json[FirestoreUsersFields.displayName],
      email: json[FirestoreUsersFields.email],
      scannedQrCodes:
          List<String>.from(json[FirestoreUsersFields.scannedQrCodes]),
      gainedPoints: json[FirestoreUsersFields.gainedPoints],
      isWinner: json[FirestoreUsersFields.isWinner],
      lastScannedQrCodeTime:
          (json[FirestoreUsersFields.lastScannedQrCodeTime] as Timestamp?),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is User &&
            runtimeType == other.runtimeType &&
            userId == other.userId &&
            displayName == other.displayName &&
            email == other.email &&
            scannedQrCodes == other.scannedQrCodes &&
            gainedPoints == other.gainedPoints &&
            isWinner == other.isWinner &&
            lastScannedQrCodeTime == other.lastScannedQrCodeTime;
  }

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          displayName,
          email,
          scannedQrCodes,
          gainedPoints,
          isWinner,
          lastScannedQrCodeTime,
        ],
      );
}
