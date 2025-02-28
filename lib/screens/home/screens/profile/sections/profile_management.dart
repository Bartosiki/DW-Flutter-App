import 'package:dw_flutter_app/constants/app_colors.dart';
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
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            strings.profileDeleteConfirmation,
            style: TextStyle(color: AppColors.loginAgreementTextColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  strings.deleteProfile1,
                  style: TextStyle(color: AppColors.loginAgreementTextColor),
                ),
                Text(
                  strings.deleteProfile2,
                  style: TextStyle(color: AppColors.loginAgreementTextColor),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                strings.profileCancelDelete,
                style: TextStyle(
                    color: AppColors.loginAgreementHighlightTextColor),
              ),
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
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.backgroundColor,
                      content: Row(
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.defaultMainColor,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Deleting profile...",
                            style: TextStyle(
                                color: AppColors.loginAgreementTextColor),
                          )
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
                  print('ReauthRequiredException');
                  if (profileContext.mounted) {
                    Navigator.of(profileContext).pop();
                  }

                  // Show re-auth required dialog
                  if (profileContext.mounted) {
                    showDialog(
                      context: profileContext,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.backgroundColor,
                        title: Text(
                          "Reauth needed",
                          style: TextStyle(
                              color: AppColors.loginAgreementTextColor),
                        ),
                        content: Text(
                          "Reauth message needed",
                          style: TextStyle(
                              color: AppColors.loginAgreementTextColor),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Logout user
                              ref.read(authStateProvider.notifier).logOut();
                              // Close profile screen
                              Navigator.of(profileContext).pop();
                            },
                            child: Text(
                              'OK',
                              style:
                                  TextStyle(color: AppColors.defaultMainColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } catch (e) {
                  // Close loading dialog if open
                  print('Error deleting profile: $e');
                  if (profileContext.mounted) {
                    Navigator.of(profileContext).pop();
                    Navigator.of(profileContext).pop();
                  }

                  if (profileContext.mounted) {
                    showDialog(
                      context: profileContext,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.backgroundColor,
                        title: Text(
                          'Error',
                          style: TextStyle(
                              color: AppColors.loginAgreementTextColor),
                        ),
                        content: Text(
                          strings.profileDeleteFailed,
                          style: TextStyle(
                              color: AppColors.loginAgreementTextColor),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ref.read(authStateProvider.notifier).logOut();
                              Navigator.of(profileContext).pop();
                            },
                            child: Text(
                              'OK',
                              style:
                                  TextStyle(color: AppColors.defaultMainColor),
                            ),
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
