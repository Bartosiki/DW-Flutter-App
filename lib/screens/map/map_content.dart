import 'package:dw_flutter_app/components/screen_switch.dart';
import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/provider/images/map_images_provider.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/screens/map/map_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapContent extends ConsumerWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsyncValue = ref.watch(mapImagesProvider);
    final selectedLanguage = ref.watch(languageProvider);
    final strings = selectedLanguage == LanguageSettings.defaultLanguage
        ? StringsEn.en
        : StringsPl.pl;

    return imagesAsyncValue.when(
      data: (images) {
        if (images == null || images.isEmpty) {
          return Center(child: Text(strings.noMapImagesError));
        }
        return ScreenSwitch(
          leftLabel: strings.groundFloor,
          rightLabel: strings.firstFloor,
          leftScreen: MapContainer(
            image: Image.network(images[0]),
          ),
          rightScreen: MapContainer(
            image: Image.network(images[1]),
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(strings.errorLoadingMapImages),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
