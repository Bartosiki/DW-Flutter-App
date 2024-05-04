import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/map_variant.dart';
import '../../../provider/map_variant/map_variant_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapVariant = ref.watch(mapVariantProvider);

    const Map<MapVariant, Widget> mapImages = {
      MapVariant.ground: Image(
        image: AssetImage('assets/images/map_poland_1.jpg'),
      ),
      MapVariant.floor: Image(
        image: AssetImage('assets/images/map_poland_2.png'),
      ),
    };

    return Scaffold(
      body: Center(
        child: mapImages[mapVariant],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(mapVariantProvider.notifier).switchMapVariant();
        },
        child: const Icon(Icons.change_circle_outlined),
      ),
    );
  }
}
