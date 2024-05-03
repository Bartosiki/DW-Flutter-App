import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firestore_collections.dart';
import '../../model/partner.dart';

final partnersProvider = StreamProvider.autoDispose<List<Partner>>((ref) {
  final controller = StreamController<List<Partner>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final subscription = FirebaseFirestore.instance
      .collection(FirestoreCollections.partners)
      .snapshots()
      .listen(
    (snapshot) {
      final documents = snapshot.docs;
      final partners = documents
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (doc) => Partner.fromJson(
              doc.data(),
            ),
          )
          .toList();
      controller.sink.add(partners);
    },
  );

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});
