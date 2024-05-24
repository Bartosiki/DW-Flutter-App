import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';

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
    return ToggleButtons(
      borderRadius: BorderRadius.circular(16),
      isSelected: [widget.isPointsSortingSelected, !widget.isPointsSortingSelected],
      onPressed: (index) {
        if (index == 0) {
          widget.onPointsPressed();
        } else {
          widget.onNamePressed();
        }
        _toggleSort();
      },
      children: const [
        SizedBox(
          width: 100,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                ),
                SizedBox(width: 6),
                Text(Strings.points),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sort_by_alpha_rounded,
                  size: 16,
                ),
                SizedBox(width: 6),
                Text(Strings.name),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
