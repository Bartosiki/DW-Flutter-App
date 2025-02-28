import 'package:dw_flutter_app/exceptions/reauth_required_exception.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/provider/auth/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Widget> buildProfileManagement(BuildContext context, WidgetRef ref) {
  final strings = ref.watch(selectedStringsProvider);
  final profileContext = context;

  Future<void> showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(strings.profileDeleteConfirmation),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(strings.deleteProfile1),
                Text(strings.deleteProfile2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(strings.profileCancelDelete),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text(strings.profileDeleteButton),
              onPressed: () async {
                try {
                  // Close the confirmation dialog first
                  Navigator.of(dialogContext).pop();

                  // Show loading dialog
                  showDialog(
                    context: profileContext,
                    barrierDismissible: false,
                    builder: (context) => const AlertDialog(
                      content: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 20),
                          Text("Deleting profile...")
                        ],
                      ),
                    ),
                  );

                  // Delete the profile
                  await ref.read(authStateProvider.notifier).deleteProfile();

                  // Close loading dialog
                  if (profileContext.mounted) {
                    Navigator.of(profileContext).pop();
                  }

                  // Close the profile modal using the original context
                  if (profileContext.mounted) {
                    Navigator.of(profileContext).pop();
                  }
                } on ReauthRequiredException {
                  // Close loading dialog if open
                  if (profileContext.mounted) {
                    Navigator.of(profileContext).pop();
                  }

                  // Show re-auth required dialog
                  if (profileContext.mounted) {
                    showDialog(
                      context: profileContext,
                      builder: (context) => AlertDialog(
                        // title: Text(strings.recentAuthNeeded),
                        // content: Text(strings.deleteProfileReauthMessage),
                        title: Text("Reauth needed"),
                        content: Text("Reauth message needed"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Logout user
                              ref.read(authStateProvider.notifier).logOut();
                              // Close profile screen
                              Navigator.of(profileContext).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                } catch (e) {
                  // Close loading dialog if open
                  if (profileContext.mounted) {
                    Navigator.of(profileContext).pop();
                  }

                  if (profileContext.mounted) {
                    showDialog(
                      context: profileContext,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: Text(strings.profileDeleteFailed),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  return [
    const SizedBox(height: 20),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: showDeleteConfirmationDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          'Delete Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    const SizedBox(height: 20),
  ];
}
