import 'package:dw_flutter_app/constants/image_sizes.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/model/partner.dart';
import 'package:dw_flutter_app/provider/combined_partners_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
