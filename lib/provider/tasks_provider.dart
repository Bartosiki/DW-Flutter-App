import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/firestore_collections.dart';
import '../model/task.dart';

final tasksProvider = AutoDisposeStreamProvider<List<Task>>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.tasks)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Task.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
});
