import 'package:dw_flutter_app/views/map/map_view.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MapView(),
      ),
    );
  }
}
