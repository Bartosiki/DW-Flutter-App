import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_fields.dart';

class UserFinishedTask {
  final int points;
  final String qrCode;
  final Timestamp finishedAt;

  UserFinishedTask({
    required this.points,
    required this.qrCode,
    required this.finishedAt,
  });

  factory UserFinishedTask.fromJson(Map<String, dynamic> json) {
    return UserFinishedTask(
      points: json[FirestoreUserFinishedTaskFields.points],
      qrCode: json[FirestoreUserFinishedTaskFields.qrCode],
      finishedAt: json[FirestoreUserFinishedTaskFields.finishedAt],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreUserFinishedTaskFields.points: points,
      FirestoreUserFinishedTaskFields.qrCode: qrCode,
      FirestoreUserFinishedTaskFields.finishedAt: finishedAt,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserFinishedTask &&
            runtimeType == other.runtimeType &&
            points == other.points &&
            qrCode == other.qrCode &&
            finishedAt == other.finishedAt;
  }

  @override
  int get hashCode => Object.hashAll(
        [
          points,
          qrCode,
          finishedAt,
        ],
      );
}
