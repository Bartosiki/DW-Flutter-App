import 'package:dw_flutter_app/views/home/tab_screen.dart';
import 'package:flutter/material.dart';

class DefaultBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const DefaultBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              enableFeedback: true,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                ...getBottomNavigationItems(context),
              ],
              currentIndex: widget.selectedIndex,
              onTap: (index) {
                widget.onItemSelected(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
