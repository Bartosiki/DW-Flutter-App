import 'package:dw_flutter_app/components/screen_description.dart';
import 'package:dw_flutter_app/components/tasks/task_list.dart';
import 'package:dw_flutter_app/constants/paths.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/provider/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YourTasksSubpage extends ConsumerWidget {
  const YourTasksSubpage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = 5;
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
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScreenDescription(
                      description: Strings.taskScreenDescription,
                      trailingIcon: SvgPicture.asset(
                        Paths.sortIcon,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn
                        ),
                      )
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Strings.youHaveXPoints(points),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Expanded(child: TaskList(tasks: tasks))
                ],
              ),
            ),
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
