import 'package:dw_flutter_app/provider/home_subpage/home_subpage_provider.dart';
import 'package:dw_flutter_app/screens/home/screens/home/events_subpage.dart';
import 'package:dw_flutter_app/screens/home/screens/home/jobs_subpage.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../components/screen_switch.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    return ScreenSwitch(
        leftScreen: EventsSubpage(),
        rightScreen: JobsSubpage(),
        leftIcon: const Icon(Icons.calendar_today),
        rightIcon: const Icon(Icons.work),
        leftLabel: strings.events,
        rightLabel: strings.jobs,
        onSwitch: ref.read(homeSubpageProvider.notifier).switchHomeSubpage,
    );
  }
}