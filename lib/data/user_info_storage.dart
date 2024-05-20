import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dw_flutter_app/constants/firestore_collections.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:dw_flutter_app/exceptions/task_not_found.dart';
import 'package:dw_flutter_app/exceptions/user_not_found.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../exceptions/task_already_finished.dart';
import '../model/task.dart';
import '../model/user.dart';
import '../model/user_finished_task.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<void> saveOrUpdateUserInfoAfterSignIn({
    required String userId,
    required String? displayName,
    required String? email,
  }) async {
    final userInfo = await FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .where(FirestoreUsersFields.userId, isEqualTo: userId)
        .limit(1)
        .get();
    if (userInfo.docs.isNotEmpty) {
      await userInfo.docs.first.reference.update(
        {
          FirestoreUsersFields.displayName: displayName,
          FirestoreUsersFields.email: email,
        },
      );
      return;
    } else {
      final payload = {
        FirestoreUsersFields.userId: userId,
        FirestoreUsersFields.displayName: displayName,
        FirestoreUsersFields.email: email,
        FirestoreUsersFields.finishedTasks: [],
        FirestoreUsersFields.gainedPoints: 0,
        FirestoreUsersFields.isWinner: false,
        FirestoreUsersFields.allowedNotifications: false,
        FirestoreUsersFields.lastScannedQrCodeTime: null,
      };
      await FirebaseFirestore.instance
          .collection(
            FirestoreCollections.users,
          )
          .add(
            payload,
          );
      return;
    }
  }

  Future<Task> finishTask(
    String userId,
    String qrCode,
    List<Task> allTasks,
  ) async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .where(FirestoreUsersFields.userId, isEqualTo: userId)
        .limit(1)
        .get();
    if (userSnapshot.docs.isEmpty) {
      throw UserNotFound(userId);
    }
    final userDoc = userSnapshot.docs.first;
    final user = User.fromJson(userDoc.data());

    final task = allTasks.firstWhereOrNull((task) => task.qrCode == qrCode);
    if (task == null) {
      throw TaskNotFound(qrCode);
    }

    if (user.finishedTasks.any((task) => task.qrCode == qrCode)) {
      throw TaskAlreadyFinished(userId, task.taskId, qrCode);
    }

    final newFinishedTasks = [
      ...user.finishedTasks,
      UserFinishedTask(
        taskId: task.taskId,
        qrCode: qrCode,
        points: task.points,
        finishedAt: Timestamp.now(),
      ),
    ];

    await userDoc.reference.update(
      {
        FirestoreUsersFields.finishedTasks: newFinishedTasks
            .map(
              (finishedTask) => finishedTask.toJson(),
            )
            .toList(),
        FirestoreUsersFields.gainedPoints: newFinishedTasks
            .map(
              (finishedTask) => finishedTask.points,
            )
            .sum,
        FirestoreUsersFields.lastScannedQrCodeTime:
            FieldValue.serverTimestamp(),
      },
    );

    return task;
  }

  Future<void> changeNotificationStatus(
    String userId,
    bool newStatus,
  ) async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .where(FirestoreUsersFields.userId, isEqualTo: userId)
        .limit(1)
        .get();
    if (userSnapshot.docs.isEmpty) {
      throw UserNotFound(userId);
    }
    final userDoc = userSnapshot.docs.first;

    await userDoc.reference.update(
      {
        FirestoreUsersFields.allowedNotifications: newStatus,
      },
    );
  }
}
