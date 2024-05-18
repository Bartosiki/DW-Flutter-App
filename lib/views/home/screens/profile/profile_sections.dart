import 'package:dw_flutter_app/components/tasks/standings_info_card.dart';
import 'package:dw_flutter_app/constants/image_sizes.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/model/partner.dart';
import 'package:dw_flutter_app/provider/auth/auth_state_provider.dart';
import 'package:dw_flutter_app/provider/combined_partners_provider.dart';
import 'package:dw_flutter_app/provider/combined_patrons_provider.dart';
import 'package:dw_flutter_app/provider/dark_mode/dark_mode_notifier.dart';
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
              fontSize: 22,
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

List<Widget> buildProfileSettings(BuildContext context, WidgetRef ref) {
  final userInfo = ref.watch(userInfoProvider);
  final darkModeState = ref.watch(darkModeProvider.notifier);
  final isDarkModeEnabled = ref.watch(darkModeProvider);

  return [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Strings.darkMode,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        Switch.adaptive(
          value: isDarkModeEnabled,
          onChanged: (value) {
            darkModeState.setDarkMode(value);
          },
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Strings.allowedNotifications,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        Switch.adaptive(
          value: userInfo.value?.allowedNotifications ?? false,
          onChanged: (value) {
            ref
                .read(authStateProvider.notifier)
                .changeNotificationStatus(value);
          },
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Strings.logOut,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await ref.read(authStateProvider.notifier).logOut();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    ),
  ];
}

List<Widget> buildProfilePatrons(BuildContext context, WidgetRef ref) {
  final combinedPatrons = ref.watch(combinedPatronsProvider);

  return [
    combinedPatrons.when(
      data: (data) {
        final patrons = data['patrons'];
        final patronImages = data['patronImages'];

        if (patrons == null ||
            patrons.isEmpty ||
            patronImages == null ||
            patronImages.isEmpty) {
          return const Center(
            child: Text(
              Strings.empty,
            ),
          );
        }
        return SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.0,
            runSpacing: 12.0,
            children: patronImages.map<Widget>(
              (path) {
                return SizedBox(
                  height: ImageSizes.goldPackagePartnerSize,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        path as String,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return const Center(
          child: Text(
            Strings.error,
          ),
        );
      },
    ),
  ];
}

List<Widget> buildProfilePartners(BuildContext context, WidgetRef ref) {
  final combinedPartners = ref.watch(combinedPartnersProvider);

  return [
    combinedPartners.when(
      data: (data) {
        final partners = data['partners'];
        final partnerImages = data['partnerImages'];

        if (partners == null ||
            partners.isEmpty ||
            partnerImages == null ||
            partnerImages.isEmpty) {
          return const Center(
            child: Text(
              Strings.empty,
            ),
          );
        }
        final partnersSorted =
            partners.map((partner) => partner as Partner).toList()
              ..sort(
                (a, b) => PartnerPackage.getPackageOrder(a.package).compareTo(
                  PartnerPackage.getPackageOrder(b.package),
                ),
              );

        return SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.0,
            runSpacing: 12.0,
            children: partnersSorted.map<Widget>(
              (partner) {
                final partnerImageUrl =
                    (partnerImages as List<String>).firstWhere(
                  (partnerImage) => Uri.decodeComponent(partnerImage)
                      .contains(partner.imageSrc),
                  orElse: () => '',
                );

                return SizedBox(
                  height: switch (partner.package) {
                    PartnerPackage.gold => ImageSizes.goldPackagePartnerSize,
                    PartnerPackage.silver =>
                      ImageSizes.silverPackagePartnerSize,
                    PartnerPackage.standard =>
                      ImageSizes.standardPackagePartnerSize,
                    _ => ImageSizes.standardPackagePartnerSize
                  },
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: partnerImageUrl.isNotEmpty
                          ? Image.network(
                              partnerImageUrl,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              alignment: Alignment.center,
                              color: Theme.of(context).colorScheme.surfaceTint,
                              child: Text(
                                partner.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return const Center(
          child: Text(
            Strings.error,
          ),
        );
      },
    ),
  ];
}
