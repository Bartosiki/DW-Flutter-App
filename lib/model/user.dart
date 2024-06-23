import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:dw_flutter_app/model/user_finished_task.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String? userId;
  final String displayName;
  final String email;
  final List<UserFinishedTask> finishedTasks;
  final int gainedPoints;
  final bool isWinner;
  final bool allowedNotifications;
  final Timestamp? lastScannedQrCodeTime;

  const User({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.finishedTasks,
    required this.gainedPoints,
    required this.isWinner,
    required this.allowedNotifications,
    required this.lastScannedQrCodeTime,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json[FirestoreUsersFields.userId],
      displayName: json[FirestoreUsersFields.displayName] ?? 'Guest',
      email: json[FirestoreUsersFields.email] ?? '',
      finishedTasks: (json[FirestoreUsersFields.finishedTasks] as List)
          .map(
            (task) => UserFinishedTask.fromJson(
              task,
            ),
          )
          .toList(),
      gainedPoints: json[FirestoreUsersFields.gainedPoints],
      isWinner: json[FirestoreUsersFields.isWinner],
      allowedNotifications: json[FirestoreUsersFields.allowedNotifications],
      lastScannedQrCodeTime:
          json[FirestoreUsersFields.lastScannedQrCodeTime] as Timestamp?,
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
            finishedTasks == other.finishedTasks &&
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
          finishedTasks,
          gainedPoints,
          isWinner,
          lastScannedQrCodeTime,
        ],
      );
}
