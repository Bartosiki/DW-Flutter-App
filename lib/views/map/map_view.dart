import 'package:dw_flutter_app/components/screen_switch.dart';
import 'package:dw_flutter_app/views/map/map_container.dart';
import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  final String leftLabel = "Ground Floor";
  final String rightLabel = "First Floor";

  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
      leftLabel: leftLabel,
      rightLabel: rightLabel,
      leftScreen: MapContainer(
        image: Image.asset(
          'assets/images/ground_floor.png',
        ),
      ),
      rightScreen: MapContainer(
        image: Image.asset(
          'assets/images/first_floor.png',
        ),
      ),
    );
  }
}
