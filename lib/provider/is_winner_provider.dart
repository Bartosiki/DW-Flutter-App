import 'package:dw_flutter_app/provider/remaining_time_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'user_info_provider.dart';

final isWinnerProvider = Provider.autoDispose<bool?>((ref) {
  final remainingTime = ref.watch(remainingTimeProvider);
  final userInfo = ref.watch(userInfoProvider);

  if (remainingTime == null || remainingTime != 0 || userInfo.value == null) {
    return null;
  }

  return userInfo.value!.isWinner;
});
