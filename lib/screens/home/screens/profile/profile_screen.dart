import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/screens/home/screens/profile/profile_element.dart';
import 'package:dw_flutter_app/screens/home/screens/profile/sections/account_details.dart';
import 'package:dw_flutter_app/screens/home/screens/profile/sections/account_settings.dart';
import 'package:dw_flutter_app/screens/home/screens/profile/sections/partners.dart';
import 'package:dw_flutter_app/screens/home/screens/profile/sections/patrons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          strings.profile,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ProfileElement(
                  title: strings.accountDetailsTitle,
                  children: buildProfileAccountDetails(context, ref),
                ),
                ProfileElement(
                  title: strings.settingsTitle,
                  children: buildProfileSettings(context, ref),
                ),
                ProfileElement(
                  title: strings.patronsTitle,
                  children: buildProfilePatrons(context, ref),
                ),
                ProfileElement(
                  title: strings.partnersTitle,
                  children: buildProfilePartners(context, ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
