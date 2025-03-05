import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/base_text.dart';
import '../../components/rich_text_widget.dart';
import 'package:flutter/gestures.dart';

class LoginScreenTermsAgreementWidget extends ConsumerWidget {
  const LoginScreenTermsAgreementWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    // For web, use a simple RichText directly instead of the custom component
    if (kIsWeb) {
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Color(0xFFE7E7E7),
            fontSize: 14.0,
          ),
          children: [
            TextSpan(text: strings.bySigningUpYouAgreeToOur + ' '),
            TextSpan(
              text: strings.termsOfService,
              style: const TextStyle(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(Uri.parse(
                      "https://www.termsfeed.com/live/6d1a6e95-0273-4420-a182-a49a4ddaab27"));
                },
            ),
            TextSpan(text: ' ' + strings.andConfirmThatYouHaveReadOur + ' '),
            TextSpan(
              text: strings.privacyPolicy,
              style: const TextStyle(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(Uri.parse(
                      "https://www.termsfeed.com/live/67eaed96-67a4-4a87-8864-fd45719dcf24"));
                },
            ),
            TextSpan(text: ' ' + strings.toLearnMoreAboutHowWeUseYourData),
          ],
        ),
      );
    }

    // Use your existing implementation for mobile
    return RichTextWidget(
      styleForAll: TextStyle(
        color: AppColors.loginAgreementTextColor,
        fontSize: 14.0, // Explicitly set font size
        // Force proper text rendering on web with stronger approach
        shadows: kIsWeb
            ? const [Shadow(color: Colors.transparent, offset: Offset(0, 0))]
            : null,
        height: 1.5, // Add line height for better rendering
      ),
      texts: [
        BaseText.plain(
          text: strings.bySigningUpYouAgreeToOur,
        ),
        BaseText.link(
          text: strings.termsOfService,
          onTapped: () {
            launchUrl(
              Uri.parse(
                "https://www.termsfeed.com/live/6d1a6e95-0273-4420-a182-a49a4ddaab27",
              ),
            );
          },
          style: TextStyle(
            color: AppColors.loginAgreementTextColor,
            decoration: TextDecoration.underline,
          ),
        ),
        BaseText.plain(text: strings.andConfirmThatYouHaveReadOur),
        BaseText.link(
          text: strings.privacyPolicy,
          onTapped: () {
            launchUrl(
              Uri.parse(
                "https://www.termsfeed.com/live/67eaed96-67a4-4a87-8864-fd45719dcf24",
              ),
            );
          },
          // Explicitly set link style to ensure consistency on web
          style: TextStyle(
            color: AppColors.loginAgreementTextColor,
            decoration: TextDecoration.underline,
          ),
        ),
        BaseText.plain(text: strings.toLearnMoreAboutHowWeUseYourData),
      ],
    );
  }
}
