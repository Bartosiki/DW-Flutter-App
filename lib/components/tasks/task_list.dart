import 'package:dw_flutter_app/model/task.dart';
import 'package:flutter/material.dart';
import 'package:dw_flutter_app/components/tasks/task_card.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasks,});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks.elementAt(index);
        return TaskCard(
          title: task.title,
          subtitle: task.description,
          points: task.points
        );
      },
    );
  }
}
