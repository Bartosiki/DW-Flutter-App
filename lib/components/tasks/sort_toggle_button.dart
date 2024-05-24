import 'package:dw_flutter_app/config/language_settings.dart';
import 'package:dw_flutter_app/constants/strings_en.dart';
import 'package:dw_flutter_app/constants/strings_pl.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SortToggleButton extends StatefulWidget {
  SortToggleButton({
    super.key,
    required this.isPointsSortingSelected,
    required this.onPointsPressed,
    required this.onNamePressed,
  });

  final void Function() onPointsPressed, onNamePressed;
  bool isPointsSortingSelected;

  @override
  State<SortToggleButton> createState() => _SortToggleButtonState();
}

class _SortToggleButtonState extends State<SortToggleButton> {
  void _toggleSort() {
    setState(() {
      widget.isPointsSortingSelected = !widget.isPointsSortingSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final selectedLanguage = ref.watch(languageProvider);
        final strings = selectedLanguage == LanguageSettings.defaultLanguage
            ? StringsEn.en
            : StringsPl.pl;

        return ToggleButtons(
          borderRadius: BorderRadius.circular(16),
          isSelected: [
            widget.isPointsSortingSelected,
            !widget.isPointsSortingSelected
          ],
          onPressed: (index) {
            if (index == 0) {
              widget.onPointsPressed();
            } else {
              widget.onNamePressed();
            }
            _toggleSort();
          },
          children: [
            SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(strings.points),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sort_by_alpha_rounded,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(strings.name),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
