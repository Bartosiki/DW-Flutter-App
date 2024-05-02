import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_collections.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:flutter/foundation.dart' show immutable;

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
}
