import 'package:dw_flutter_app/components/custom_switch.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/views/home/screens/tasks/standings_subpage.dart';
import 'package:dw_flutter_app/views/home/screens/tasks/your_tasks_subpage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../provider/tasks_subpage/tasks_subpage_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomSwitch(
      firstScreen: const YourTasksSubpage(),
      secondScreen: const StandingsSubpage(),
      firstLabel: Strings.tasks,
      secondLabel: Strings.standings,
      onSwitch: ref.read(tasksSubpageProvider.notifier).switchTasksSubpage,
    );
  }
}
