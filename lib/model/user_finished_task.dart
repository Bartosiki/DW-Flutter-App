import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_fields.dart';

class UserFinishedTask {
  final int taskId;
  final int points;
  final String qrCode;
  final Timestamp finishedAt;

  UserFinishedTask({
    required this.taskId,
    required this.points,
    required this.qrCode,
    required this.finishedAt,
  });

  factory UserFinishedTask.fromJson(Map<String, dynamic> json) {
    return UserFinishedTask(
      taskId: json[FirestoreUserFinishedTaskFields.taskId],
      points: json[FirestoreUserFinishedTaskFields.points],
      qrCode: json[FirestoreUserFinishedTaskFields.qrCode],
      finishedAt: json[FirestoreUserFinishedTaskFields.finishedAt],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreUserFinishedTaskFields.taskId: taskId,
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
            taskId == other.taskId &&
            points == other.points &&
            qrCode == other.qrCode &&
            finishedAt == other.finishedAt;
  }

  @override
  int get hashCode => Object.hashAll(
        [
          taskId,
          points,
          qrCode,
          finishedAt,
        ],
      );
}
