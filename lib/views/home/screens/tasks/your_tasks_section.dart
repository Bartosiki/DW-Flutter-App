import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/provider/tasks/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YourTasksSection extends ConsumerWidget {
  const YourTasksSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return tasks.when(
      data: (tasks) {
        if (tasks.isEmpty) {
          return const Center(
            child: Text(
              Strings.empty,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks.elementAt(index);
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                onTap: () {},
              );
            },
          );
        }
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Center(
        child: Text(
          Strings.error,
        ),
      ),
    );
  }
}
