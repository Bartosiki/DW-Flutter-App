import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/tasks_subpages.dart';
import '../../../provider/tasks_subpage_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subpage = ref.watch(tasksSubpageProvider);

    const Map<TasksSubpage, Widget> subpageWidgets = {
      TasksSubpage.yourTasks: Text(
        Strings.yourTasks,
      ),
      TasksSubpage.standings: Text(
        Strings.standings,
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
