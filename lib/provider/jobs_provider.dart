import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_collections.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:dw_flutter_app/model/job.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final jobsProvider = AutoDisposeStreamProvider<List<Job>>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.jobs)
      .orderBy(
    FirestoreJobFields.companyName,
    descending: false,
  )
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
    )
        .map(
          (doc) {
        final jobData = doc.data();
        return Job.fromJson({
          ...jobData,
          'id': doc.id, // Include document ID
        });
      },
    )
        .toList(),
  );
});