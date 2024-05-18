import 'package:dw_flutter_app/provider/images/image_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final patronImagesProvider = FutureProvider<List<String>?>(
  (ref) async => await getMapImages("patrons/"),
);
