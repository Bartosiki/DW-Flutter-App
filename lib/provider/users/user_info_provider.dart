import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/auth/provider/user_id_provider.dart';
import 'package:dw_flutter_app/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firestore_collections.dart';
import '../../constants/firestore_fields.dart';

final userInfoProvider = StreamProvider.autoDispose<User>((ref) {
  final controller = StreamController<User>();

  controller.onListen = () {
    controller.sink.add(User.unknown());
  };

  final subscription = FirebaseFirestore.instance
      .collection(FirestoreCollections.users)
      .where(
        FirestoreUsersFields.userId,
        isEqualTo: ref.watch(userIdProvider),
      )
      .limit(1)
      .snapshots()
      .listen(
    (snapshot) {
      final documents = snapshot.docs;
      if (documents.isEmpty) {
        return;
      }
      final userInfo = User.fromJson(
        documents.first.data(),
      );
      controller.sink.add(userInfo);
    },
  );

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});
