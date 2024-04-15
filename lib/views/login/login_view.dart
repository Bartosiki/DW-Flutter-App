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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Image(
                    image: AssetImage("assets/images/dw_logo_white.png"),
                    height: 120.0,
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
              Column(
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
                  const DividerWithMargins(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: LoginViewTermsAgreementWidget(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
