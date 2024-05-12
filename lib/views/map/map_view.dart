import 'package:dw_flutter_app/components/screen_switch.dart';
import 'package:dw_flutter_app/views/map/map_container.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dw_flutter_app/constants/strings.dart';

import '../../provider/image_provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  String? images;

  @override
  void initState() {
    super.initState();
    getMapImages().then((value) {
      setState(() {
        images = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSwitch(
      leftLabel: Strings.groundFloor,
      rightLabel: Strings.firstFloor,
      leftScreen: MapContainer(
        image: Image.network(images!),
      ),
      rightScreen: MapContainer(
        image: Image.network(images!),
      ),
    );
  }
}
