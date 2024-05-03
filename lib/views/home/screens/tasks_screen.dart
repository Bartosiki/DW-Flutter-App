import 'package:dw_flutter_app/components/tasks/task_list.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/tasks_subpages.dart';
import '../../../provider/tasks_subpage_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  final int points = 15;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subpage = ref.watch(tasksSubpageProvider);
    final List<Map<String, dynamic>> tasks = [
      {"title": "Task 1", "subtitle": "Description for Task 1", "points": 10},
      {"title": "Task 2", "subtitle": "Description for Task 2", "points": 20},
      {"title": "Task 3", "subtitle": "Description for Task 3", "points": 15},
      {"title": "Task 4", "subtitle": "Description for Task 4", "points": 20},
      {"title": "Task 5", "subtitle": "Description for Task 5", "points": 25},
      {"title": "Task 6", "subtitle": "Description for Task 6", "points": 30},
      {"title": "Task 7", "subtitle": "Description for Task 7", "points": 35},
      {"title": "Task 8", "subtitle": "Description for Task 8", "points": 40},
    ];

    const Map<TasksSubpage, Widget> subpageWidgets = {
      TasksSubpage.yourTasks: Text(
        Strings.yourTasks,
      ),
      TasksSubpage.standings: Text(
        Strings.standings,
      ),
    };

    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Strings.youHaveXPoints(points),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TaskList(tasks: tasks)
          ],
        ),
      );
  }
}
