import 'package:dw_flutter_app/provider/calendar_subpage/calendar_subpage_provider.dart';
import 'package:dw_flutter_app/screens/home/screens/calendar/calendar_events_screen.dart';
import 'package:dw_flutter_app/screens/home/screens/calendar/calendar_jobs_screen.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../components/screen_switch.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    return ScreenSwitch(
        leftScreen: CalendarEventsScreen(),
        rightScreen: CalendarJobsScreen(),
        leftIcon: const Icon(Icons.star),
        rightIcon: const Icon(Icons.leaderboard),
        leftLabel: strings.events,
        rightLabel: strings.jobs,
        onSwitch: ref.read(calendarSubpageProvider.notifier).switchCalendarSubpage,
    );
  }
}