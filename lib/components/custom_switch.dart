import 'package:flutter/material.dart';

enum Option { first, second }

class CustomSwitch extends StatefulWidget {
  const CustomSwitch(
      {super.key,
      required this.firstScreen,
      required this.secondScreen,
      required this.firstLabel,
      required this.secondLabel,
      this.onSwitch});

  final Widget firstScreen;
  final Widget secondScreen;
  final String firstLabel;
  final String secondLabel;
  final void Function()? onSwitch;

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSwitched = false;
  Option optionView = Option.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                child: SegmentedButtonTheme(
                  data: SegmentedButtonThemeData(
                    style: SegmentedButton.styleFrom(
                      side: BorderSide.none,
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
                        label: Text(widget.firstLabel),
                      ),
                      ButtonSegment<Option>(
                        value: Option.second,
                        label: Text(widget.secondLabel),
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
                child: optionView == Option.first
                      ? widget.firstScreen
                      : widget.secondScreen,
              ),
            ],
          ),
        ),
    );
  }
}