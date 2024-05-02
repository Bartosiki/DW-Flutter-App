<<<<<<< HEAD
import 'package:dw_flutter_app/components/default_bottom_navigation_bar.dart';
import 'package:dw_flutter_app/views/home/screens/profile_screen.dart';
=======
import 'package:dw_flutter_app/auth/provider/auth_state_provider.dart';
import 'package:dw_flutter_app/components/custom_switch.dart';
import 'package:dw_flutter_app/views/map/map_view.dart';
>>>>>>> 0530cb8 (add props to switch)
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'tab_screen.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedIndex = 0;
  final List<TabScreen> _screens = [
    for (final screen in TabScreen.values) screen,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_selectedIndex].screen,
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
<<<<<<< HEAD
=======
      body: const Center(child: MapView()),
>>>>>>> 0530cb8 (add props to switch)
    );
  }
}

void showProfileScreen(BuildContext context) {
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const ProfileScreen();
    },
  );
}
