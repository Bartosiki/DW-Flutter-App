import 'package:dw_flutter_app/exceptions/reauth_required_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../network/authenticator.dart';
import '../../model/auth_result.dart';
import '../../model/auth_state.dart';
import '../../data/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadySignedIn) {
      state = AuthState(
        result: _authenticator.isAnonymous
            ? AuthResult.anonymous
            : AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.signOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.signInWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      try {
        await _userInfoStorage.saveOrUpdateUserInfoAfterSignIn(
          userId: userId,
          displayName: _authenticator.displayName,
          email: _authenticator.email,
        );
        state = AuthState(
          result: result,
          isLoading: false,
          userId: userId,
        );
      } catch (error) {
        state = const AuthState.unknown();
        return;
      }
    } else {
      state = const AuthState.unknown();
    }
  }

  Future<void> loginWithApple() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.signInWithApple();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      try {
        await _userInfoStorage.saveOrUpdateUserInfoAfterSignIn(
          userId: userId,
          displayName: _authenticator.displayName,
          email: _authenticator.email,
        );
        state = AuthState(
          result: result,
          isLoading: false,
          userId: userId,
        );
      } catch (error) {
        state = const AuthState.unknown();
        return;
      }
    } else {
      state = const AuthState.unknown();
    }
  }

  Future<void> loginAnonymously() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.signInAnonymously();
    final userId = _authenticator.userId;
    if (result == AuthResult.anonymous && userId != null) {
      try {
        await _userInfoStorage.saveOrUpdateUserInfoAfterSignIn(
          userId: userId,
          displayName: 'Guest',
          email: '',
        );
        state = AuthState(
          result: result,
          isLoading: false,
          userId: userId,
        );
      } catch (error) {
        state = const AuthState.unknown();
        return;
      }
    } else {
      state = const AuthState.unknown();
    }
  }

  Future<void> changeNotificationStatus(bool status) async {
    state = state.copiedWithIsLoading(true);
    final userId = _authenticator.userId;
    if (userId != null) {
      try {
        await _userInfoStorage.changeNotificationStatus(userId, status);
        state = state.copiedWithIsLoading(false);
      } catch (error) {
        state = const AuthState.unknown();
      }
    } else {
      state = const AuthState.unknown();
    }
  }

  Future<void> deleteProfile({Function? onDeleted}) async {
    state = state.copiedWithIsLoading(true);
    final userId = _authenticator.userId;
    if (userId != null) {
      try {
        await _userInfoStorage.deleteUserInfo(userId);
        try {
          await _authenticator.deleteAccount();
        } on ReauthRequiredException {
          bool reauthSuccess = false;

          // Try re-authentication based on current auth method
          if (!_authenticator.isAnonymous) {
            // Try to determine if user signed in with Google or Apple
            // You might want to store this info when they sign in
            reauthSuccess = await _authenticator.reauthenticateWithGoogle();

            if (!reauthSuccess) {
              reauthSuccess = await _authenticator.reauthenticateWithApple();
            }
          }

          if (reauthSuccess) {
            // Try deleting again after re-authentication
            await _authenticator.deleteAccount();
          } else {
            throw const ReauthRequiredException();
          }
        }

        state = const AuthState.unknown();
        if (onDeleted != null) {
          onDeleted();
        }
      } catch (error) {
        state = state.copiedWithIsLoading(false);
        throw error;
      }
    }
  }
}
