import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/auth/auth_state_provider.dart';
import '../../provider/auth/is_user_anonymous_provider.dart';
import '../../provider/selected_strings_provider.dart';

class OnlyForLoggedUserScreen extends ConsumerWidget {
  const OnlyForLoggedUserScreen({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUserAnonymous = ref.watch(isUserAnonymousProvider);
    final strings = ref.watch(selectedStringsProvider);

    if (isUserAnonymous) {
      return Stack(
        children: [
          Blur(
            blur: 6,
            blurColor: Colors.black,
            child: content,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    strings.availableOnlyForLoggedUsers,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(authStateProvider.notifier).logOut();
                    },
                    child: Text(
                      strings.signInWithGoogleOrApple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return content;
    }
  }
}
