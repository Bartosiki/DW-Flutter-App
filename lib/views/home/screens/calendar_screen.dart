import 'package:dw_flutter_app/components/calendar/event_card.dart';
import 'package:dw_flutter_app/extensions/log.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/strings.dart';
import '../../../provider/events_provider.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    return events.when(
      data: (events) {
        if (events.isEmpty) {
          return const Center(
            child: Text(
              Strings.empty,
            ),
          );
        } else {
          return EventCard();
        }
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        error.log();
        return const Center(
          child: Text(
            Strings.error,
          ),
        );
      },
    );
  }
}
