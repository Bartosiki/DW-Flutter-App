import 'package:dw_flutter_app/provider/images/patron_images_provider.dart';
import 'package:dw_flutter_app/provider/patrons_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final combinedPatronsProvider = FutureProvider.autoDispose((ref) async {
  final patrons = await ref.watch(patronsProvider.future);
  final patronImages = await ref.watch(patronImagesProvider.future);

  return {
    'patrons': patrons,
    'patronImages': patronImages,
  };
});
