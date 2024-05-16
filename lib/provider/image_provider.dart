import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

final mapImagesProvider = FutureProvider<List<String>?>(
  (ref) async => await getMapImages(),
);

Future<List<String>?> getMapImages() async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("maps/");
    final images = await imagesRef.listAll();
    final downloadURLs =
        await Future.wait(images.items.map((e) => e.getDownloadURL()));
    return downloadURLs.toList();
  } catch (e) {
    print("Error fetching images: $e");
    return null;
  }
}
