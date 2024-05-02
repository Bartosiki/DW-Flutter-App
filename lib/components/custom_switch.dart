import 'package:flutter/material.dart';

enum Option { first, second }

class CustomSwitch extends StatefulWidget {
  const CustomSwitch(
      {super.key,
      required this.firstScreen,
      required this.secondScreen,
      required this.firstLabel,
      required this.secondLabel});

  final Widget firstScreen;
  final Widget secondScreen;
  final String firstLabel;
  final String secondLabel;

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
                  child: SegmentedButtonTheme(
                    data: const SegmentedButtonThemeData(),
                    child: SegmentedButton<Option>(
                      style: SegmentedButton.styleFrom(
                        shape: const CircleBorder(
                          side: BorderSide(
                            width: 0,
                          ),
                        ),
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        selectedForegroundColor: Colors.white,
                        selectedBackgroundColor: Colors.grey[800],
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity:
                            const VisualDensity(horizontal: -3, vertical: -3),
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
                        });
                      },
                    ),
                  )),
              const SizedBox(height: 20.0),
              Expanded(
                child: Expanded(
                  child: optionView == Option.first
                      ? widget.firstScreen
                      : widget.secondScreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
