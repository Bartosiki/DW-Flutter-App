import 'package:dw_flutter_app/components/tasks/task_card.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TaskCard(
                title: "Witamy na wydziale",
                subtitle: "Szukaj gdzie pieprz rośnie a jak opis za długi to niech też rośnie",
                points: 5,
              ),
            ],
          ),
        )
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
