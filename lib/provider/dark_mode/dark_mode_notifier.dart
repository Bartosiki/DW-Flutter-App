import 'package:dw_flutter_app/provider/dark_mode/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dw_flutter_app/config/color_scheme_settings.dart';

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier(super.initialState);

  static Brightness get initialBrightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  static Future<DarkModeNotifier> create() async {
    final isDarkMode =
        await ColorSchemeSettings.isDarkModeEnabled(initialBrightness);
    return DarkModeNotifier(isDarkMode);
  }

  Future<void> setDarkMode(bool value) async {
    state = value;
    await ColorSchemeSettings.setDarkModeEnabled(value);
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  final darkModeNotifierFuture = ref.watch(darkModeNotifierProvider);
  return (darkModeNotifierFuture.value ??
      DarkModeNotifier(DarkModeNotifier.initialBrightness == Brightness.dark));
});
