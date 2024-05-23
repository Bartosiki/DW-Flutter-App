import 'package:dw_flutter_app/components/tasks/standings_info_card.dart';
import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StandingsInfoCardRow extends ConsumerWidget {
  const StandingsInfoCardRow({
    super.key,
    required this.timeLeft,
    required this.position,
  });

  final String timeLeft;
  final String position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageProvider);
    final strings = selectedLanguage == LanguageSettings.defaultLanguage
        ? StringsEn.en
        : StringsPl.pl;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StandingsInfoCard(
          title: timeLeft,
          subtitle: strings.timeLeft,
        ),
        const SizedBox(width: 24),
        StandingsInfoCard(
          title: position,
          subtitle: strings.yourPlace,
        ),
      ],
    );
  }
}
