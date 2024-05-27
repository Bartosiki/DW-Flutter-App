import 'package:dw_flutter_app/provider/auth/auth_state_provider.dart';
import 'package:dw_flutter_app/provider/dark_mode/dark_mode_notifier.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/provider/user_info_provider.dart';
import 'package:dw_flutter_app/screens/home/screens/profile/language_select.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Widget> buildProfileSettings(BuildContext context, WidgetRef ref) {
  final userInfo = ref.watch(userInfoProvider);
  final darkModeState = ref.watch(darkModeProvider.notifier);
  final isDarkModeEnabled = ref.watch(darkModeProvider);
  final strings = ref.watch(selectedStringsProvider);

  return [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          strings.darkMode,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
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
          strings.notifications,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
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
          strings.selectedLanguage,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
        ),
        const LanguageSelect(),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          strings.logOut,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
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
