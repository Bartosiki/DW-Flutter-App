import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:dw_flutter_app/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firestore_collections.dart';
import '../../model/top_player.dart';

final topPlayersProvider = StreamProvider<List<TopPlayer>>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.users)
      .orderBy(FirestoreUsersFields.gainedPoints, descending: true)
      .limit(10)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map(
          (doc) {
            final userData = User.fromJson(doc.data());
            return TopPlayer(
              displayName: userData.displayName,
              gainedPoints: userData.gainedPoints,
            );
          },
        ).toList(),
      );
});
