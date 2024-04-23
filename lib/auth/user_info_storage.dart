import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<void> saveUserInfo({
    required String userId,
    required String? displayName,
    required String? email,
  }) async {
    final userInfo = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();
    if (userInfo.docs.isNotEmpty) {
      await userInfo.docs.first.reference.update(
        {
          'displayName': displayName,
          'email': email,
        },
      );
      return;
    } else {
      final payload = {
        'userId': userId,
        'displayName': displayName,
        'email': email,
      };
      await FirebaseFirestore.instance
          .collection(
            'users',
          )
          .add(
            payload,
          );
      return;
    }
  }
}
