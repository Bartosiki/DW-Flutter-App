import 'package:dw_flutter_app/provider/images/partner_images_provider.dart';
import 'package:dw_flutter_app/provider/partners_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final combinedPartnersProvider = FutureProvider.autoDispose((ref) async {
  final partners = await ref.watch(partnersProvider.future);
  final partnerImages = await ref.watch(partnerImagesProvider.future);

  return {
    'partners': partners,
    'partnerImages': partnerImages,
  };
});
