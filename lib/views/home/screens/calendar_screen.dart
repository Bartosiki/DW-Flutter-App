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
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events.elementAt(index);
              return ListTile(
                title: Text(event.title),
                subtitle: Text(event.description),
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
