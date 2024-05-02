import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_collections.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:dw_flutter_app/model/event.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eventsProvider = StreamProvider.autoDispose<Iterable<Event>>((ref) {
  final controller = StreamController<Iterable<Event>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final subscription = FirebaseFirestore.instance
      .collection(FirestoreCollections.events)
      .where(FirestoreEventsFields.timeEnd, isGreaterThan: DateTime.now())
      .orderBy(
        FirestoreEventsFields.timeStart,
        descending: true,
      )
      .snapshots()
      .listen(
    (snapshot) {
      final documents = snapshot.docs;
      final events = documents
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (doc) => Event.fromJson(
              doc.data(),
            ),
          );
      controller.sink.add(events);
    },
  );

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});
