import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/provider/auth/user_id_provider.dart';
import 'package:dw_flutter_app/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/firestore_collections.dart';
import '../constants/firestore_fields.dart';

final userInfoProvider = AutoDisposeStreamProvider<User>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.users)
      .where(
        FirestoreUsersFields.userId,
        isEqualTo: ref.watch(userIdProvider),
      )
      .limit(1)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => User.fromJson(
                doc.data(),
              ),
            )
            .first,
      );
});
