import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_collections.dart';
import 'package:dw_flutter_app/model/config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final configProvider = AutoDisposeStreamProvider<Config>((ref) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollections.config)
      .limit(1)
      .snapshots()
      .map(
        (querySnapshot) => querySnapshot.docs
            .map(
              (doc) => Config.fromJson(
                doc.data(),
              ),
            )
            .first,
      );
});
