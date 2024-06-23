import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/auth_result.dart';
import 'auth_state_provider.dart';

final isUserAnonymousProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.anonymous;
});
