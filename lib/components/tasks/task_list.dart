import 'package:flutter/material.dart';
import 'package:dw_flutter_app/components/tasks/task_card.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasks});

  final List<Map<String, dynamic>> tasks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: tasks.map((task) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: TaskCard(
                title: task['title'],
                subtitle: task['subtitle'],
                points: task['points'],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
