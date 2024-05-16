import 'package:dw_flutter_app/components/screen_switch.dart';
import 'package:dw_flutter_app/views/map/map_container.dart';
import 'package:flutter/material.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../provider/image_provider.dart';

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsyncValue = ref.watch(mapImagesProvider);

    return imagesAsyncValue.when(
      data: (images) {
        if (images == null || images.isEmpty) {
          return const Center(child: Text(Strings.noMapImagesError));
        } else {
          return ScreenSwitch(
            leftLabel: Strings.groundFloor,
            rightLabel: Strings.firstFloor,
            leftScreen: MapContainer(
              image: Image.network(images[0]),
            ),
            rightScreen: MapContainer(
              image: Image.network(images[1]),
            ),
          );
        }
      },
      error: (error, stackTrace) =>
          const Center(child: Text(Strings.errorLoadingMapImages)),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
