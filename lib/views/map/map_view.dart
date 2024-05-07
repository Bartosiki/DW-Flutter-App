import 'package:dw_flutter_app/components/screen_switch.dart';
import 'package:dw_flutter_app/views/map/map_container.dart';
import 'package:flutter/material.dart';
import 'package:dw_flutter_app/constants/strings.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSwitch(
      leftLabel: Strings.groundFloor,
      rightLabel: Strings.firstFloor,
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
