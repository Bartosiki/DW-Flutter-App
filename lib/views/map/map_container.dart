import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MapContainer extends StatelessWidget {
  const MapContainer({super.key, required this.image});

  final Image image;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(20),
      minScale: 0.1,
      maxScale: 4.0,
      child: image,
    );
  }
}
