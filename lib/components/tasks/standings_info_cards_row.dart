import 'package:dw_flutter_app/components/tasks/standings_info_card.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StandingsInfoCardRow extends ConsumerWidget {
  const StandingsInfoCardRow({
    super.key,
    required this.timeLeft,
    required this.position,
  });

  final String timeLeft;
  final String position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StandingsInfoCard(
          title: timeLeft,
          subtitle: strings.timeLeft,
        ),
        const SizedBox(width: 24),
        StandingsInfoCard(
          title: position,
          subtitle: strings.yourPlace,
        ),
      ],
    );
  }
}
