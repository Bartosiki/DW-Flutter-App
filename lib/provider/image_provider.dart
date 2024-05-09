import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future<List<Reference>?> getMapImages() async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("/maps");
    final images = await imagesRef.listAll();
    return images.items;
  } catch (e) {
    print("Error fetching images");
    print(e);
  }
}
