import 'dart:async';
import 'dart:ffi';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'contest_time_provider.dart';

final remainingTimeProvider = Provider.autoDispose<int?>((ref) {
  final contestTime = ref.watch(contestTimeProvider);
  Timer? timer;
  ref.state = null;

  if (contestTime.value != null) {
    final remainingTime =
        contestTime.value!.difference(DateTime.now()).inSeconds;
    ref.state = remainingTime > 0 ? remainingTime : 0;
  }

  timer = Timer.periodic(const Duration(seconds: 1), (_) {
    if (contestTime.value != null) {
      final remainingTime =
          contestTime.value!.difference(DateTime.now()).inSeconds;
      ref.state = remainingTime > 0 ? remainingTime : 0;
    }
  });

  ref.onDispose(() {
    timer?.cancel();
  });

  return ref.state;
});
