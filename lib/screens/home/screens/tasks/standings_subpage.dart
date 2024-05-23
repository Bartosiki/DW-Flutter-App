import 'package:dw_flutter_app/components/divider_with_margins.dart';
import 'package:dw_flutter_app/components/screen_description.dart';
import 'package:dw_flutter_app/components/tasks/separated_standing.dart';
import 'package:dw_flutter_app/components/tasks/standings_card.dart';
import 'package:dw_flutter_app/components/tasks/standings_info_cards_row.dart';
import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../provider/remaining_time_provider.dart';
import '../../../../provider/top_players_provider.dart';
import '../../../../provider/user_ranking_position_provider.dart';

class StandingsSubpage extends ConsumerWidget {
  const StandingsSubpage({super.key});

  String getTimeLeftFormatted(int? remainingTime) {
    if (remainingTime == null) {
      return 'loading..';
    }

    var hours = remainingTime ~/ 3600;
    var minutes = (remainingTime % 3600) ~/ 60;

    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = ref.watch(remainingTimeProvider);
    final topPlayers = ref.watch(topPlayersProvider);
    final userRankingPosition = ref.watch(userRankingPositionProvider);
    final userInfo = ref.watch(userInfoProvider);
    final selectedLanguage = ref.watch(languageProvider);
    final strings = selectedLanguage == LanguageSettings.defaultLanguage
        ? StringsEn.en
        : StringsPl.pl;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            ScreenDescription(
              description: strings.standingsScreenDescription,
            ),
            const SizedBox(height: 16),
            StandingsInfoCardRow(
              timeLeft: getTimeLeftFormatted(remainingTime),
              position: userRankingPosition.maybeWhen(
                data: (position) => "#$position",
                orElse: () => "# loading..",
              ),
            ),
            const SizedBox(height: 16),
            const DividerWithMargins(),
            const SizedBox(height: 16),
            topPlayers.when(
              data: (topPlayers) {
                if (topPlayers.isEmpty) {
                  return Center(
                    child: Text(
                      strings.empty,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    itemCount: topPlayers.length + 1,
                    itemBuilder: (context, index) {
                      if (index == topPlayers.length) {
                        return userRankingPosition.maybeWhen(
                          data: (position) => position != null && position > 10
                              ? SeparatedStanding(
                                  rankIndex: position,
                                  points: userInfo.maybeWhen(
                                    data: (info) => info.gainedPoints,
                                    orElse: () => 0,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          orElse: () => const SizedBox.shrink(),
                        );
                      }
                      final topPlayer = topPlayers.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: StandingsCard(
                          rankIndex: index + 1,
                          points: topPlayer.gainedPoints,
                          isCurrentUser: index + 1 ==
                              userRankingPosition.maybeWhen(
                                data: (position) => position,
                                orElse: () => 0,
                              ),
                          name: topPlayer.displayName,
                        ),
                      );
                    },
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
            ),
          ],
        ),
      ),
    );
  }
}
