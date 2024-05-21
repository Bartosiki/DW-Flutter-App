import 'package:dw_flutter_app/constants/image_sizes.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/provider/combined_patrons_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
