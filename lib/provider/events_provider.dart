import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_collections.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:dw_flutter_app/model/event.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eventsProvider = AutoDisposeStreamProvider<List<Event>>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.events)
      .where(FirestoreEventsFields.timeEnd, isGreaterThan: DateTime.now())
      .orderBy(
        FirestoreEventsFields.timeStart,
        descending: true,
      )
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Event.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
});
