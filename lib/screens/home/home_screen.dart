import 'package:dw_flutter_app/components/default_bottom_navigation_bar.dart';
import 'package:dw_flutter_app/provider/gemini/gemini_messages_provider.dart';
import 'package:dw_flutter_app/screens/home/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'tab_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final screens = TabScreen.getScreens(ref);

        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text(
              screens[_selectedIndex].label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              if (_selectedIndex == 4)
                IconButton(
                  icon: const Icon(Icons.rotate_left),
                  onPressed: () {
                    ref
                        .read(geminiMessagesProvider.notifier)
                        .clearChatHistory();
                  },
                ),
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
      },
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
