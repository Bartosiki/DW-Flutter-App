import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:dw_flutter_app/views/home/screens/calendar_screen.dart';
import 'package:dw_flutter_app/views/home/screens/map_screen.dart';
import 'package:dw_flutter_app/views/home/screens/qr_scanner_screen.dart';
import 'package:dw_flutter_app/views/home/screens/tasks/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/paths.dart';
import 'screens/assistant_screen.dart';

enum TabScreen {
  calendar(
    Strings.calendar,
    Paths.calendarIcon,
    CalendarScreen(),
  ),
  tasks(
    Strings.tasks,
    Paths.trophyIcon,
    TasksScreen(),
  ),
  qrScanner(
    Strings.scanner,
    Paths.qrCodeIcon,
    QrScannerScreen(),
  ),
  map(
    Strings.map,
    Paths.mapIcon,
    MapScreen(),
  ),
  assistant(
    Strings.assistant,
    Paths.aiAssistantIcon,
    AssistantScreen(),
  );

  final String label;
  final String iconPath;
  final Widget screen;

  const TabScreen(this.label, this.iconPath, this.screen);

  @override
  String toString() => label;
}

List<BottomNavigationBarItem> getBottomNavigationItems(BuildContext context) {
  return [
    for (final screen in TabScreen.values)
      BottomNavigationBarItem(
        label: screen.label,
        icon: SvgPicture.asset(
          screen.iconPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onBackground,
            BlendMode.srcIn,
          ),
        ),
        activeIcon: SvgPicture.asset(
          screen.iconPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.tertiary,
            BlendMode.srcIn,
          ),
        ),
      ),
  ];
}
