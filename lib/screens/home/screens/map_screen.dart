import 'package:dw_flutter_app/screens/map/map_content.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MapContent(),
      ),
    );
  }
}
