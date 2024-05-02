import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firestore_collections.dart';
import '../../model/task.dart';

final tasksProvider = StreamProvider.autoDispose<Iterable<Task>>((ref) {
  final controller = StreamController<Iterable<Task>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final subscription = FirebaseFirestore.instance
      .collection(FirestoreCollections.tasks)
      .orderBy(
        FirestoreTasksFields.taskId,
        descending: true,
      )
      .snapshots()
      .listen(
    (snapshot) {
      final documents = snapshot.docs;
      final tasks = documents
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (doc) => Task.fromJson(
              doc.data(),
            ),
          );
      controller.sink.add(tasks);
    },
  );

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});
