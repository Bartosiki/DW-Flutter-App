import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/firestore_collections.dart';

final contestTimeProvider = AutoDisposeStreamProvider<DateTime>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.contestTime)
      .doc(FirestoreCollections.contestTime)
      .snapshots()
      .map((snapshot) {
    final data = snapshot.data();
    final contestTime = data![FirestoreContestTimeFields.endTime] as Timestamp;
    return contestTime.toDate();
  });
});
