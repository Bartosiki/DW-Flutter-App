import 'package:dw_flutter_app/components/tasks/standings_info_card.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Widget> buildProfileAccountDetails(BuildContext context, WidgetRef ref) {
  final userInfo = ref.watch(userInfoProvider);

  final List<Widget> children = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        '${Strings.welcome} ${userInfo.value?.displayName ?? ''}',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StandingsInfoCard(
          title: userInfo.value?.finishedTasks.length.toString() ?? '0',
          subtitle: Strings.finishedTasks,
        ),
        const SizedBox(width: 24),
        StandingsInfoCard(
          title: userInfo.value?.gainedPoints.toString() ?? '0',
          subtitle: Strings.gainedPoints,
        ),
      ],
    ),
  ];

  if (userInfo.value?.isWinner ?? false) {
    children.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow,
                offset: Offset(0.0, 2.0),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(
                color: Colors.yellow,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Text(
                Strings.winner,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  return children;
}
