import 'package:dw_flutter_app/components/platform_aware_icon.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/screens/home/screens/home/home_screen.dart';
import 'package:dw_flutter_app/screens/home/screens/map_screen.dart';
import 'package:dw_flutter_app/screens/home/screens/qr_scanner_screen.dart';
import 'package:dw_flutter_app/screens/home/screens/tasks/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../constants/paths.dart';

enum TabScreenType {
  home,
  tasks,
  qrScanner,
  map,
  assistant,
}

class TabScreen {
  final TabScreenType type;
  final String label;
  final String iconPath;
  final Widget screen;

  TabScreen(this.type, this.label, this.iconPath, this.screen);

  @override
  String toString() {
    return label;
  }

  static List<TabScreen> getScreens(WidgetRef ref) {
    final strings = ref.watch(selectedStringsProvider);

    return [
      TabScreen(
        TabScreenType.home,
        strings.home,
        Paths.homeIcon,
        const HomeScreen(),
      ),
      TabScreen(
        TabScreenType.tasks,
        strings.tasks,
        Paths.trophyIcon,
        const TasksScreen(),
      ),
      TabScreen(
        TabScreenType.qrScanner,
        strings.scanner,
        Paths.qrCodeIcon,
        const QrScannerScreen(),
      ),
      TabScreen(
        TabScreenType.map,
        strings.map,
        Paths.mapIcon,
        const MapScreen(),
      ),
    ];
  }
}

List<BottomNavigationBarItem> getBottomNavigationItems(
    BuildContext context, WidgetRef ref) {
  final screens = TabScreen.getScreens(ref);

  return screens.map(
    (screen) {
      return BottomNavigationBarItem(
        label: screen.label,
        icon: PlatformAwareIcon(
          iconPath: screen.iconPath,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        activeIcon: PlatformAwareIcon(
          iconPath: screen.iconPath,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    },
  ).toList();
}
