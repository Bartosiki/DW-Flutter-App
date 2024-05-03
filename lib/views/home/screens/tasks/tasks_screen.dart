import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/views/home/screens/tasks/your_tasks_section.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/tasks_subpages.dart';
import '../../../../provider/contest_time/contestTimeProvider.dart';
import '../../../../provider/tasks_subpage/tasks_subpage_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subpage = ref.watch(tasksSubpageProvider);
    final contestTime = ref.watch(contestTimeProvider);

    Map<TasksSubpage, Widget> subpageWidgets = {
      TasksSubpage.yourTasks: const YourTasksSection(),
      TasksSubpage.standings: contestTime.when(
        data: (contestTime) {
          return Text(
            "Contest ends at ${contestTime.toIso8601String()}",
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => const Text(Strings.error),
      ),
    };

    return Scaffold(
      body: Center(
        child: subpageWidgets[subpage],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(tasksSubpageProvider.notifier).switchTasksSubpage();
        },
        child: const Icon(Icons.switch_left),
      ),
    );
  }
}
