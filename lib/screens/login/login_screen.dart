import 'package:dw_flutter_app/components/divider_with_margins.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/screens/login/login_button.dart';
import 'package:dw_flutter_app/screens/login/login_screen_terms_agreement_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../provider/auth/auth_state_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 600.0,
                      child: Lottie.asset(
                        "assets/animations/kitty.json",
                        reverse: true,
                      ),
                    ),
                    LoginButton(
                      text: Strings.continueWithGoogle,
                      imagePath: "assets/images/google_logo.png",
                      onPressed: () {
                        ref.read(authStateProvider.notifier).loginWithGoogle();
                      },
                    ),
                    const SizedBox(height: 12.0),
                    LoginButton(
                      text: Strings.continueWithApple,
                      imagePath: "assets/images/apple_logo.png",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12.0),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: DividerWithMargins(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: LoginScreenTermsAgreementWidget(),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Image(
                      image: AssetImage("assets/images/dw_logo_white.png"),
                      height: 100.0,
                    ),
                    const SizedBox(height: 26.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 64.0),
                      child: Text(
                        Strings.signUpToTakePartInOurEvent,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}