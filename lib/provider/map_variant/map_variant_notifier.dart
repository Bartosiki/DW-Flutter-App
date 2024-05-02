import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/map_variant.dart';

class MapVariantNotifier extends StateNotifier<MapVariant> {
  MapVariantNotifier()
      : super(
          MapVariant.ground,
        );

  void switchMapVariant() {
    state = state == MapVariant.ground ? MapVariant.floor : MapVariant.ground;
  }

  void setMapVariant(MapVariant variant) {
    state = variant;
  }
}
