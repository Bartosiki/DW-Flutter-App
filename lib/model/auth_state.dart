import 'package:flutter/foundation.dart' show immutable;
import 'auth_result.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final String? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : this(result: null, isLoading: false, userId: null);

  AuthState copiedWithIsLoading(bool isLoading) {
    return AuthState(
      result: result,
      isLoading: isLoading,
      userId: userId,
    );
  }

  @override
  String toString() {
    return 'AuthState{result: $result, isLoading: $isLoading, userId: $userId}';
  }

  @override
  bool operator ==(covariant AuthState other) {
    if (identical(this, other)) return true;
    return result == other.result &&
        isLoading == other.isLoading &&
        userId == other.userId;
  }

  @override
  int get hashCode => Object.hashAll([result, isLoading, userId]);
}
