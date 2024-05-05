import 'package:flutter/material.dart';

enum Option { first, second }

class CustomSwitch extends StatefulWidget {
  const CustomSwitch(
      {super.key,
      required this.leftScreen,
      required this.rightScreen,
      required this.leftLabel,
      required this.rightLabel});

  final Widget leftScreen;
  final Widget rightScreen;
  final String leftLabel;
  final String rightLabel;

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSwitched = false;
  Option optionView = Option.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30.0),
                width: double.infinity,
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
                    });
                  },
                ),
              ),
              const SizedBox(height: 20.0),
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
      ),
    );
  }
}
