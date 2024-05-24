import 'package:dw_flutter_app/components/divider_with_margins.dart';
import 'package:dw_flutter_app/model/task.dart';
import 'package:dw_flutter_app/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:dw_flutter_app/components/tasks/task_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskList extends ConsumerWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required this.sortByPoints,
    required this.isAscending,
  });

  final List<Task> tasks;
  final bool sortByPoints, isAscending;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);

    for (var element in tasks) {
      element.isDone = userInfo.maybeWhen(
        data: (userInfo) => userInfo.finishedTasks.any(
          (finishedTask) => finishedTask.taskId == element.taskId,
        ),
        orElse: () => false,
      );
    }

    tasks.sort((a, b) {
      if (a.isDone && !b.isDone) return 1;
      if (!a.isDone && b.isDone) return -1;

      int comparison;
      if (sortByPoints) {
        comparison = a.points.compareTo(b.points);
      } else {
        comparison = a.title.compareTo(b.title);
      }

      return isAscending ? comparison : -comparison;
    });

    final undoneTasks = tasks.where((task) => !task.isDone).toList();
    final doneTasks = tasks.where((task) => task.isDone).toList();

    final List<Widget> taskWidgets = [
      ...undoneTasks.map((task) => TaskCard(
        title: task.title,
        subtitle: task.description,
        points: task.points,
        isDone: task.isDone,
      )),
      if (doneTasks.isNotEmpty && undoneTasks.isNotEmpty)
        const DividerWithMargins(),
      ...doneTasks.map((task) => TaskCard(
        title: task.title,
        subtitle: task.description,
        points: task.points,
        isDone: task.isDone,
      )),
    ];

    return ListView.builder(
      itemCount: taskWidgets.length,
      itemBuilder: (context, index) {
        return taskWidgets[index];
      },
    );
  }
}

