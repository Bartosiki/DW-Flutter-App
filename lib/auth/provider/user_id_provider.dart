import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_state_provider.dart';

final userIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.userId;
});
