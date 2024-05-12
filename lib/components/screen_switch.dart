import 'package:flutter/material.dart';

enum Option { first, second }

class ScreenSwitch extends StatefulWidget {
  const ScreenSwitch(
      {super.key,
      required this.leftScreen,
      required this.rightScreen,
      required this.leftLabel,
      required this.rightLabel,
      this.onSwitch});

  final Widget leftScreen;
  final Widget rightScreen;
  final String leftLabel;
  final String rightLabel;
  final void Function()? onSwitch;

  @override
  _ScreenSwitchState createState() => _ScreenSwitchState();
}

class _ScreenSwitchState extends State<ScreenSwitch> {
  bool isSwitched = false;
  Option optionView = Option.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              width: double.infinity,
              child: SegmentedButtonTheme(
                data: SegmentedButtonThemeData(
                  style: SegmentedButton.styleFrom(side: BorderSide.none),
                ),
                child: SegmentedButton<Option>(
                  style: SegmentedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    selectedForegroundColor:
                        Theme.of(context).colorScheme.onPrimary,
                    selectedBackgroundColor:
                        Theme.of(context).colorScheme.primary,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: -2,
                      vertical: -2,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 19.0),
                  ),
                  showSelectedIcon: false,
                  segments: <ButtonSegment<Option>>[
                    ButtonSegment<Option>(
                      value: Option.first,
                      label: Text(widget.leftLabel),
                    ),
                    ButtonSegment<Option>(
                      value: Option.second,
                      label: Text(widget.rightLabel),
                    ),
                  ],
                  selected: {optionView},
                  onSelectionChanged: (Set<Option> newSelection) {
                    setState(() {
                      optionView = newSelection.first;
                      widget.onSwitch?.call();
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: optionView == Option.first
                  ? widget.leftScreen
                  : widget.rightScreen,
            ),
          ],
        ),
      ),
    );
  }
}
