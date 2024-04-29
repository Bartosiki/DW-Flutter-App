import 'package:flutter/material.dart';

enum Option { first, second }

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  // final Widget firstScreen;
  // final Widget secondScreen;

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
                        const VisualDensity(horizontal: -3, vertical: -3),
                  ),
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<Option>>[
                    ButtonSegment<Option>(
                      value: Option.first,
                      label: Text('Your tasks'),
                    ),
                    ButtonSegment<Option>(
                      value: Option.second,
                      label: Text('Standings'),
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
                      ? const Text('First')
                      : const Text('Second'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
