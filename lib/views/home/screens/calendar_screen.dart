import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/strings.dart';
import '../home_view.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            Strings.calendar,
          ),
          TextButton(
            onPressed: () {
              showProfileScreen(context);
            },
            child: const Text('Show Profile Screen'),
          ),
        ],
      ),
    );
  }
}
