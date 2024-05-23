import 'package:dw_flutter_app/screens/home/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DefaultBottomNavigationBar extends ConsumerStatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const DefaultBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  ConsumerState<DefaultBottomNavigationBar> createState() =>
      _DefaultBottomNavigationBarState();
}

class _DefaultBottomNavigationBarState
    extends ConsumerState<DefaultBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
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
                    ...getBottomNavigationItems(context, ref),
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
      },
    );
  }
}
