import 'dart:async';
import 'package:dw_flutter_app/provider/images/advertisements_images_provider.dart';
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
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      setState(() {
        _currentIndex++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final advertisementsImages = ref.watch(advertisementsImagesProvider);

    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: advertisementsImages.when(
        data: (images) {
          if (images == null || images.isEmpty) {
            return _buildBottomNavigationBar();
          }
          final advertisementUrl = images[_currentIndex % images.length];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 4 / 1,
                child: Image.network(
                  advertisementUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              _buildBottomNavigationBar(),
            ],
          );
        },
        loading: () => _buildBottomNavigationBar(),
        error: (error, stack) => _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
    );
  }
}