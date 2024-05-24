import 'package:dw_flutter_app/components/calendar/event_list.dart';
import 'package:dw_flutter_app/extensions/log.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../components/screen_description.dart';
import '../../../provider/events_provider.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    final strings = ref.watch(selectedStringsProvider);

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
                  description: strings.eventScreenDescription,
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
