import 'package:dw_flutter_app/constants/languages.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSelect extends ConsumerWidget {
  const LanguageSelect({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageProvider);
    final languageState = ref.watch(languageProvider.notifier);

    return DropdownButton<String>(
      value: selectedLanguage,
      items: AvailableLanguages.getAvailableLanguages()
          .entries
          .map(
            (entry) => DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  ClipOval(
                    child: SvgPicture.asset(
                      'assets/icons/${entry.key}.svg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(entry.value),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        languageState.setLanguage(value);
      },
    );
  }
}
