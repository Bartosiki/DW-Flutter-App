import 'package:dw_flutter_app/components/calendar/event_list.dart';
import 'package:dw_flutter_app/extensions/log.dart';
import 'package:dw_flutter_app/provider/contest_time_provider.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/utility/string_utility.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../components/screen_description.dart';
import '../../../provider/events_provider.dart';
import 'package:sprintf/sprintf.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    final strings = ref.watch(selectedStringsProvider);
    final contestTime = ref.watch(contestTimeProvider);
    final languageCode = ref.watch(languageProvider);

    return events.when(
      data: (events) {
        if (events.isEmpty) {
          return Center(
            child: Text(
              strings.empty,
            ),
          );
        }
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              'Add event'.log();
            },
            label: Text(strings.register),
            icon: const Icon(Icons.edit_outlined),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                ScreenDescription(
                  description: sprintf(strings.eventScreenDescription, [
                    formatDate(
                        contestTime.value != null
                            ? (contestTime.value as DateTime)
                            : DateTime.now(),
                        languageCode)
                  ]),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: EventList(
                    eventList: events,
                  ),
                )
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
          child: Text(
            strings.error,
          ),
        );
      },
    );
  }
}
