import 'package:dw_flutter_app/components/default_bottom_navigation_bar.dart';
import 'package:dw_flutter_app/screens/home/screens/profile/profile_screen.dart';
import 'package:dw_flutter_app/service/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'tab_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    PushNotificationService();
  }

  @override
  Widget build(BuildContext context) {
    final screens = TabScreen.getScreens(ref);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          screens[_selectedIndex].label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              showProfileScreen(context);
            },
          ),
        ],
      ),
      body: Center(
        child: screens[_selectedIndex].screen,
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
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
