import 'package:dw_flutter_app/provider/images/jobs_images_provider.dart';
import 'package:dw_flutter_app/provider/jobs_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final combinedJobsProvider = FutureProvider.autoDispose((ref) async {
  final jobs = await ref.watch(jobsProvider.future);
  final jobsImages = await ref.watch(jobsImagesProvider.future);

  final jobsWithImages = jobs.asMap().entries.map((entry) {
    final index = entry.key;
    final job = entry.value;
    final companyLogo = (jobsImages != null && index < jobsImages.length)
        ? jobsImages[index]
        : null;
    return job.copyWith(companyLogo: companyLogo);
  }).toList();

  return {
    'jobs': jobsWithImages,
  };
});