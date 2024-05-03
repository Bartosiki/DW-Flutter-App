import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dw_flutter_app/constants/firestore_collections.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:dw_flutter_app/exceptions/task_not_found.dart';
import 'package:dw_flutter_app/exceptions/user_not_found.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../exceptions/could_not_get_all_tasks.dart';
import '../exceptions/task_already_finished.dart';
import '../model/task.dart';
import '../model/user.dart';

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
        FirestoreUsersFields.scannedQrCodes: [],
        FirestoreUsersFields.gainedPoints: 0,
        FirestoreUsersFields.isWinner: false,
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

  Future<void> finishTask(String userId, String qrCode) async {
    final userInfo = await FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .where(FirestoreUsersFields.userId, isEqualTo: userId)
        .limit(1)
        .get();
    if (userInfo.docs.isEmpty) {
      throw UserNotFound(userId);
    }

    final allTasksSnapshot = await FirebaseFirestore.instance
        .collection(FirestoreCollections.tasks)
        .get();
    if (allTasksSnapshot.docs.isEmpty) {
      throw CouldNotGetAllTasks();
    }

    final userDoc = userInfo.docs.first;
    var user = User.fromJson(userDoc.data());
    final allTasks =
        allTasksSnapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();

    final task = allTasks.firstWhere(
      (task) => task.qrCode == qrCode,
      orElse: () => throw TaskNotFound(qrCode),
    );

    if (user.scannedQrCodes.contains(qrCode)) {
      throw TaskAlreadyFinished(userId, task.taskId, qrCode);
    }

    final newScannedQrCodes = [...user.scannedQrCodes, qrCode];
    await userDoc.reference.update(
      {
        FirestoreUsersFields.scannedQrCodes: newScannedQrCodes,
        FirestoreUsersFields.gainedPoints: allTasks
            .where((task) => newScannedQrCodes.contains(task.qrCode))
            .map((task) => task.points)
            .sum,
        FirestoreUsersFields.lastScannedQrCodeTime:
            FieldValue.serverTimestamp(),
      },
    );
  }
}
