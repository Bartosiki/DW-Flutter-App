import 'package:dw_flutter_app/components/custom_switch.dart';
import 'package:dw_flutter_app/views/map/map_container.dart';
import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
      firstLabel: "Ground Floor",
      secondLabel: "First Floor",
      firstScreen: MapContainer(
        image: Image.asset(
          'assets/images/ground_floor.png',
        ),
      ),
      secondScreen: MapContainer(
        image: Image.asset(
          'assets/images/first_floor.png',
        ),
      ),
    );
  }
}
