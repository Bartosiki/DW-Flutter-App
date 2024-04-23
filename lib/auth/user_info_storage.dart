import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/extensions/log.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required String userId,
    required String? displayName,
    required String? email,
  }) async {
    try {
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
        return true;
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
        return true;
      }
    } catch (e) {
      e.log();
      return false;
    }
  }
}
