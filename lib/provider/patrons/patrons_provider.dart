import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/model/patron.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firestore_collections.dart';

final patronsProvider = StreamProvider<List<Patron>>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.patrons)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Patron.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
});
