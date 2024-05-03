import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firestore_collections.dart';
import '../../model/partner.dart';

final partnersProvider = StreamProvider<List<Partner>>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.partners)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Partner.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
});
