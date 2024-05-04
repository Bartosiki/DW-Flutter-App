import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/provider/contest/remaining_time_provider.dart';
import 'package:dw_flutter_app/views/home/screens/tasks/standings_subpage.dart';
import 'package:dw_flutter_app/views/home/screens/tasks/your_tasks_subpage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/tasks_subpages.dart';
import '../../../../provider/contest/contest_time_provider.dart';
import '../../../../provider/tasks_subpage/tasks_subpage_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subpage = ref.watch(tasksSubpageProvider);

    Map<TasksSubpage, Widget> subpageWidgets = {
      TasksSubpage.yourTasks: const YourTasksSubpage(),
      TasksSubpage.standings: const StandingsSubpage(),
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
