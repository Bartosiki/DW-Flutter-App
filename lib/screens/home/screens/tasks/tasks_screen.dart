import 'package:dw_flutter_app/components/screen_switch.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/screens/home/screens/tasks/standings_subpage.dart';
import 'package:dw_flutter_app/screens/home/screens/tasks/your_tasks_subpage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../provider/tasks_subpage/tasks_subpage_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenSwitch(
      leftScreen: const YourTasksSubpage(),
      rightScreen: const StandingsSubpage(),
      leftLabel: Strings.tasks,
      rightLabel: Strings.standings,
      leftIcon: const Icon(Icons.star),
      rightIcon: const Icon(Icons.leaderboard),
      onSwitch: ref.read(tasksSubpageProvider.notifier).switchTasksSubpage,
    );
  }
}
