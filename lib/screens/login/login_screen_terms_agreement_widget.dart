import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/base_text.dart';
import '../../components/rich_text_widget.dart';

class LoginScreenTermsAgreementWidget extends ConsumerWidget {
  const LoginScreenTermsAgreementWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageProvider);
    final strings = selectedLanguage == LanguageSettings.defaultLanguage
        ? StringsEn.en
        : StringsPl.pl;

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
