class ReauthRequiredException implements Exception {
  const ReauthRequiredException();

  @override
  String toString() => 'This operation requires recent authentication';
}
