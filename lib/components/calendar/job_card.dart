import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/selected_strings_provider.dart';

class JobCard extends ConsumerWidget {
  const JobCard({
    super.key,
    required this.title,
    required this.companyName,
    required this.companyLogo,
    this.salaryRange,
    this.description,
    required this.offerUrl,
  });

  final String title;
  final String companyName;
  final String companyLogo;
  final String? salaryRange; // Nullable
  final String? description; // Nullable
  final String offerUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        child: ClipRect(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Enables full-screen bottom sheets
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => _buildJobDetailsBottomSheet(context),
                );
              },
              child: Stack(
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(
                        right: 40.0,
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0.6,
                          child: Text(
                            companyName,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5), // Add spacing between text
                        Text(
                          salaryRange ?? strings.salaryUndisclosed,
                          // Use default if null
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    trailing: Image.network(
                      companyLogo,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobDetailsBottomSheet(BuildContext context) {
    final strings =
        ProviderScope.containerOf(context).read(selectedStringsProvider);

    return Container(
      width: MediaQuery.of(context)
          .size
          .width, // Set the width to full screen width
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust size based on content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Company Name
            Text(
              companyName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // Salary Range
            Text(
              salaryRange != null
                  ? '${strings.salary}: ${salaryRange!}'
                  : strings.salaryUndisclosed, // Use default if null
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Job Description
            if (description != null) ...[
              Text(
                strings.jobDescription,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Offer URL
            if (offerUrl.isNotEmpty) ...[
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await launchUrl(Uri.parse(offerUrl));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Could not open the URL'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.open_in_new),
                label: Text(strings.viewOffer),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
