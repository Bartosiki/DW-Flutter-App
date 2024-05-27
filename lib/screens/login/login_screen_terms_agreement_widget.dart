import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/base_text.dart';
import '../../components/rich_text_widget.dart';

class LoginScreenTermsAgreementWidget extends ConsumerWidget {
  const LoginScreenTermsAgreementWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    return RichTextWidget(
      styleForAll: TextStyle(
        color: AppColors.loginAgreementTextColor,
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
                "https://www.google.pl/",
              ),
            );
          },
        ),
        BaseText.plain(text: strings.andConfirmThatYouHaveReadOur),
        BaseText.link(
          text: strings.privacyPolicy,
          onTapped: () {
            launchUrl(
              Uri.parse(
                "https://www.google.pl/",
              ),
            );
          },
        ),
        BaseText.plain(text: strings.toLearnMoreAboutHowWeUseYourData),
      ],
    );
  }
}
