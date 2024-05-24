import 'package:dw_flutter_app/components/divider_with_margins.dart';
import 'package:dw_flutter_app/components/tasks/standings_card.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SeparatedStanding extends ConsumerWidget {
  const SeparatedStanding({
    super.key,
    required this.rankIndex,
    required this.points,
  });

  final int rankIndex, points;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          const DividerWithMargins(),
          StandingsCard(
            rankIndex: rankIndex,
            points: points,
            isCurrentUser: true,
            name: strings.you,
          ),
        ],
      ),
    );
  }
}
