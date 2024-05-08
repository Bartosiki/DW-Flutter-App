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
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: SegmentedButtonTheme(
                  data: SegmentedButtonThemeData(
                    style: SegmentedButton.styleFrom(
                      side: BorderSide.none
                    )
                  ),
                  child: SegmentedButton<Option>(
                    style: SegmentedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      selectedForegroundColor: Colors.white,
                      selectedBackgroundColor: Colors.grey[800],
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity:
                          const VisualDensity(horizontal: -2, vertical: -2),
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
                        if (widget.onSwitch != null) {
                            widget.onSwitch!();
                        }
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Expanded(
                  child: optionView == Option.first
                      ? widget.leftScreen
                      : widget.rightScreen,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
