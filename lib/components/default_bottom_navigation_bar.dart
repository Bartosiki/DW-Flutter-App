import 'package:dw_flutter_app/views/home/tab_screen.dart';
import 'package:flutter/material.dart';

class DefaultBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const DefaultBottomNavigationBar(
      {super.key, required this.selectedIndex, required this.onItemSelected});

  @override
  State<DefaultBottomNavigationBar> createState() =>
      _DefaultBottomNavigationBarState();
}

class _DefaultBottomNavigationBarState
    extends State<DefaultBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        enableFeedback: true,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          ...bottomNavigationItems,
        ],
        currentIndex: widget.selectedIndex,
        onTap: (index) {
          widget.onItemSelected(index);
        },
      ),
    );
  }
}
