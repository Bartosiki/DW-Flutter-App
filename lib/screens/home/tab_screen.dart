import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/screens/home/screens/calendar_screen.dart';
import 'package:dw_flutter_app/screens/home/screens/map_screen.dart';
import 'package:dw_flutter_app/screens/home/screens/qr_scanner_screen.dart';
import 'package:dw_flutter_app/screens/home/screens/tasks/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../constants/paths.dart';
import 'screens/assistant_screen.dart';

enum TabScreenType {
  calendar,
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
        TabScreenType.calendar,
        strings.calendar,
        Paths.calendarIcon,
        const CalendarScreen(),
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
      TabScreen(
        TabScreenType.assistant,
        strings.assistant,
        Paths.aiAssistantIcon,
        const AssistantScreen(),
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
        icon: SvgPicture.asset(
          screen.iconPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
        activeIcon: SvgPicture.asset(
          screen.iconPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
      );
    },
  ).toList();
}
