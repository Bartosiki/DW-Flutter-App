import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/model/patron.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firestore_collections.dart';

final patronsProvider = StreamProvider.autoDispose<List<Patron>>((ref) {
  final controller = StreamController<List<Patron>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final subscription = FirebaseFirestore.instance
      .collection(FirestoreCollections.patrons)
      .snapshots()
      .listen(
    (snapshot) {
      final documents = snapshot.docs;
      final patrons = documents
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (doc) => Patron.fromJson(
              doc.data(),
            ),
          )
          .toList();
      controller.sink.add(patrons);
    },
  );

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});
