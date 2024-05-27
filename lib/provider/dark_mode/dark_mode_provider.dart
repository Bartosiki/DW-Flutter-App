import 'package:dw_flutter_app/provider/dark_mode/dark_mode_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeNotifierProvider = FutureProvider<DarkModeNotifier>(
  (ref) {
    return DarkModeNotifier.create();
  },
);
