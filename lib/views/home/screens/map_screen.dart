import 'package:dw_flutter_app/views/map/map_view.dart';
import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../../model/map_variant.dart';
// import '../../../provider/map_variant/map_variant_provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final mapVariant = ref.watch(mapVariantProvider);

    // const Map<MapVariant, Widget> mapImages = {
    //   MapVariant.ground: Image(
    //     image: AssetImage('assets/images/map_poland_1.jpg'),
    //   ),
    //   MapVariant.floor: Image(
    //     image: AssetImage('assets/images/map_poland_2.png'),
    //   ),
    // };

    return const Scaffold(
      body: Center(
        child: MapView(),
      ),
    );
  }
}
