import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future<String?> getMapImages() async {
  try {
    print("Fetching images");
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("maps/ground_floor.png");
    final images = await imagesRef.getDownloadURL();
    return images;
  } catch (e) {
    print("Error fetching images");
    print(e);
    return null;
  }
}
