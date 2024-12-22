import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JobCard extends ConsumerWidget {
  const JobCard({
    super.key,
    required this.title,
    required this.companyName,
    required this.companyLogo,
    required this.salaryRange,
  });

  final String title;
  final String companyName;
  final String companyLogo;
  final String salaryRange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                          salaryRange,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjust size based on content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            companyName,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Salary: $salaryRange',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}