import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth/user_id_provider.dart';
import '../constants/firestore_collections.dart';

final userRankingPositionProvider = AutoDisposeStreamProvider<int?>((ref) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) {
    return Stream.value(null);
  }
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.users)
      .orderBy(FirestoreUsersFields.gainedPoints, descending: true)
      .snapshots()
      .map((snapshot) {
    final data = snapshot.docs;
    final userRanking = data.indexWhere(
      (doc) => doc.data()[FirestoreUsersFields.userId] == userId,
    );
    return userRanking + 1;
  });
});
