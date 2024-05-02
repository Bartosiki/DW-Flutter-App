import 'package:dw_flutter_app/model/tasks_subpages.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TasksSubpageNotifier extends StateNotifier<TasksSubpage> {
  TasksSubpageNotifier() : super(TasksSubpage.yourTasks);

  void switchTasksSubpage() {
    state = state == TasksSubpage.yourTasks
        ? TasksSubpage.standings
        : TasksSubpage.yourTasks;
  }

  void changeTasksSubpage(TasksSubpage subpage) {
    state = subpage;
  }
}
