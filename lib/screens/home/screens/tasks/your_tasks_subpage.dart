import 'package:dw_flutter_app/components/screen_description.dart';
import 'package:dw_flutter_app/components/tasks/task_list.dart';
import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/paths.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/provider/tasks_provider.dart';
import 'package:dw_flutter_app/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';

class YourTasksSubpage extends ConsumerWidget {
  const YourTasksSubpage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final tasks = ref.watch(tasksProvider);
    final selectedLanguage = ref.watch(languageProvider);
    final strings = selectedLanguage == LanguageSettings.defaultLanguage
        ? StringsEn.en
        : StringsPl.pl;

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
                const SizedBox(height: 8),
                ScreenDescription(
                  description: strings.taskScreenDescription,
                  trailingIcon: SvgPicture.asset(
                    Paths.sortIcon,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onBackground,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                userInfo.when(
                  data: (user) {
                    return Text(
                      sprintf(
                        strings.youHaveXPoints,
                        [user.gainedPoints],
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
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
                Expanded(child: TaskList(tasks: tasks)),
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
