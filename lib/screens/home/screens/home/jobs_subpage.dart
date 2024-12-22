import 'package:dw_flutter_app/components/calendar/jobs_list.dart';
import 'package:dw_flutter_app/provider/combined_jobs_provider.dart';
import 'package:dw_flutter_app/provider/config_provider.dart';
import 'package:dw_flutter_app/provider/contest_time_provider.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/utility/string_utility.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../components/screen_description.dart';
import 'package:sprintf/sprintf.dart';

class JobsSubpage extends ConsumerWidget {
  JobsSubpage({super.key});
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static const registrationErrorSnackbar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combinedJobs = ref.watch(combinedJobsProvider);
    final strings = ref.watch(selectedStringsProvider);
    final contestTime = ref.watch(contestTimeProvider);
    final languageCode = ref.watch(languageProvider);
    final config = ref.watch(configProvider);

    return combinedJobs.when(
      data: (data) {
        final jobs = data['jobs'];
        if (jobs == null || jobs.isEmpty) {
          return Center(
            child: Text(
              strings.empty,
            ),
          );
        }
        return ScaffoldMessenger(
          key: _scaffoldMessengerKey,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  ScreenDescription(
                    description: sprintf(strings.jobsScreenDescription, [
                      formatDate(
                          contestTime.value != null
                              ? (contestTime.value as DateTime)
                              : DateTime.now(),
                          languageCode)
                    ]),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: JobsList(
                      jobList: jobs,
                    ),
                  )
                ],
              ),
            ),
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
    );
  }
}
