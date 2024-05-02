import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/map_variant.dart';
import 'map_variant_notifier.dart';

final mapVariantProvider =
    StateNotifierProvider<MapVariantNotifier, MapVariant>(
  (ref) => MapVariantNotifier(),
);
