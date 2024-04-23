import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/auth_state.dart';
import '../notifier/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);
