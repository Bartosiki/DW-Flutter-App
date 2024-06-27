import 'package:dw_flutter_app/components/screen_description.dart';
import 'package:dw_flutter_app/components/tasks/sort_modal_content.dart';
import 'package:dw_flutter_app/components/tasks/task_list.dart';
import 'package:dw_flutter_app/constants/paths.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/provider/tasks_provider.dart';
import 'package:dw_flutter_app/provider/user_info_provider.dart';
import 'package:dw_flutter_app/screens/home/screens/tasks/sorting_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';

class YourTasksSubpage extends ConsumerStatefulWidget {
  const YourTasksSubpage({super.key});

  @override
  ConsumerState<YourTasksSubpage> createState() {
    return _YourTasksSubpageState();
  }
}

class _YourTasksSubpageState extends ConsumerState<YourTasksSubpage> {
  var _sortType = SortType.points;
  var _orderType = OrderType.ascending;

  void _onPointsPressed() {
    setState(() {
      _sortType = SortType.points;
    });
  }

  void _onNamePressed() {
    setState(() {
      _sortType = SortType.name;
    });
  }

  void _onOrderPressed() {
    setState(() {
      if (_orderType == OrderType.ascending) {
        _orderType = OrderType.descending;
      } else {
        _orderType = OrderType.ascending;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInfoProvider);
    final tasks = ref.watch(tasksProvider);
    final strings = ref.watch(selectedStringsProvider);

    return tasks.when(
      data: (tasks) {
        if (tasks.isEmpty) {
          return Center(
            child: Text(
              strings.empty,
            ),
          );
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScreenDescription(
                  description: strings.taskScreenDescription,
                  trailingIcon: IconButton(
                    icon: SvgPicture.asset(
                      Paths.sortIcon,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SortModalContent(
                            sortType: _sortType,
                            orderType: _orderType,
                            onPointsPressed: _onPointsPressed,
                            onNamePressed: _onNamePressed,
                            onOrderPressed: _onOrderPressed,
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                userInfo.when(
                  data: (user) {
                    return Text(
                      sprintf(
                        strings.youHaveXPoints,
                        [user.gainedPoints],
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) {
                    return Center(
                      child: Text(
                        strings.error,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: TaskList(
                    tasks: tasks,
                    sortByPoints: _sortType == SortType.points,
                    isAscending: _orderType == OrderType.ascending,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return Center(
          child: Text(strings.error),
        );
      },
    );
  }
}
