import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/base_text.dart';
import '../../components/rich_text_widget.dart';
import '../../constants/strings.dart';

class LoginScreenTermsAgreementWidget extends StatelessWidget {
  const LoginScreenTermsAgreementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.loginAgreementTextColor,
          ),
      texts: [
        BaseText.plain(
          text: Strings.bySigningUpYouAgreeToOur,
        ),
        BaseText.link(
          text: Strings.termsOfService,
          onTapped: () {
            launchUrl(
              Uri.parse(
                "https://www.google.pl/",
              ),
            );
          },
        ),
        BaseText.plain(text: Strings.andConfirmThatYouHaveReadOur),
        BaseText.link(
          text: Strings.privacyPolicy,
          onTapped: () {
            launchUrl(
              Uri.parse(
                "https://www.google.pl/",
              ),
            );
          },
        ),
        BaseText.plain(text: Strings.toLearnMoreAboutHowWeUseYourData),
      ],
    );
  }
}
