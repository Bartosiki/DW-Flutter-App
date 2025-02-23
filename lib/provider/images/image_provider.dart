import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>?> getImages(String storagePath) async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child(storagePath);
    print(storagePath);
    final images = await imagesRef.listAll();
    final downloadURLs =
        await Future.wait(images.items.map((e) => e.getDownloadURL()));
    return downloadURLs.toList();
  } catch (e) {
    return null;
  }
}
