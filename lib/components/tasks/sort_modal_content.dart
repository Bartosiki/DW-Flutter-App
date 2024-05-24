import 'package:dw_flutter_app/components/tasks/rotating_icon_button.dart';
import 'package:dw_flutter_app/components/tasks/sort_toggle_button.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/screens/home/screens/tasks/sorting_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SortModalContent extends StatelessWidget {
  const SortModalContent({
    super.key,
    required this.sortType,
    required this.orderType,
    required this.onPointsPressed,
    required this.onNamePressed,
    required this.onOrderPressed,
  });

  final SortType sortType;
  final OrderType orderType;
  final void Function() onPointsPressed, onNamePressed, onOrderPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    Strings.sortBy,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SortToggleButton(
                    isPointsSortingSelected: sortType == SortType.points,
                    onPointsPressed: onPointsPressed,
                    onNamePressed: onNamePressed,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    Strings.orderBy,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 0),
                  RotatingIconButton(
                    turns: orderType == OrderType.ascending ? 0.0 : 0.5,
                    onPressed: onOrderPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
