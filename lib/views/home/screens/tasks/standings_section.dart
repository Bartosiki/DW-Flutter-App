import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/provider/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../provider/contest/remaining_time_provider.dart';
import '../../../../provider/contest/top_players_provider.dart';

class StandingsSection extends ConsumerWidget {
  const StandingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = ref.watch(remainingTimeProvider);
    final topPlayers = ref.watch(topPlayersProvider);

    return SafeArea(
      child: Column(
        children: [
          Text(
            remainingTime.toString(),
          ),
          topPlayers.when(
            data: (topPlayers) {
              if (topPlayers.isEmpty) {
                return const Center(
                  child: Text(
                    Strings.empty,
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: topPlayers.length,
                    itemBuilder: (context, index) {
                      final topPlayer = topPlayers.elementAt(index);
                      return ListTile(
                        title: Text(topPlayer.displayName),
                        subtitle: Text(topPlayer.gainedPoints.toString()),
                      );
                    },
                  ),
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
          ),
        ],
      ),
    );
  }
}
