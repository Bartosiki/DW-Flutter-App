import 'package:dw_flutter_app/provider/tasks_subpage_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/tasks_subpages.dart';

final tasksSubpageProvider =
    StateNotifierProvider<TasksSubpageNotifier, TasksSubpage>(
  (ref) => TasksSubpageNotifier(),
);
