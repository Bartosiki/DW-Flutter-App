import 'package:dw_flutter_app/components/screen_switch.dart';
import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/screens/home/screens/tasks/standings_subpage.dart';
import 'package:dw_flutter_app/screens/home/screens/tasks/your_tasks_subpage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../provider/tasks_subpage/tasks_subpage_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageProvider);
    final strings = selectedLanguage == LanguageSettings.defaultLanguage
        ? StringsEn.en
        : StringsPl.pl;

    return ScreenSwitch(
      leftScreen: const YourTasksSubpage(),
      rightScreen: const StandingsSubpage(),
      leftIcon: const Icon(Icons.star),
      rightIcon: const Icon(Icons.leaderboard),
      leftLabel: strings.tasks,
      rightLabel: strings.standings,
      onSwitch: ref.read(tasksSubpageProvider.notifier).switchTasksSubpage,
    );
  }
}
