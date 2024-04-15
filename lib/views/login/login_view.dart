import 'package:dw_flutter_app/components/divider_with_margins.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/views/login/login_button.dart';
import 'package:dw_flutter_app/views/login/login_view_terms_agreement_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginButton(
                  text: Strings.continueWithGoogle,
                  imagePath: "assets/images/google_logo.png",
                  onPressed: () {},
                ),
                const SizedBox(height: 12.0),
                LoginButton(
                  text: Strings.continueWithApple,
                  imagePath: "assets/images/apple_logo.png",
                  onPressed: () {},
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
          const Column(
            children: [
              DividerWithMargins(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: LoginViewTermsAgreementWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
