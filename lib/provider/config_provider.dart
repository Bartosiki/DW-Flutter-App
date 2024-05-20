import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_collections.dart';
import 'package:dw_flutter_app/model/config.dart';
import 'package:dw_flutter_app/provider/auth/is_logged_in_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// A provider that returns the config stream only if the user is logged in
final configProvider = StreamProvider.autoDispose<Config?>((ref) {
  // Watch the isLoggedInProvider to get the authentication state
  final isLoggedIn = ref.watch(isLoggedInProvider);

  // If the user is not logged in, return an empty stream
  if (!isLoggedIn) {
    return const Stream<Config?>.empty();
  }

  // Fetch the config from Firestore if the user is logged in
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
