import 'exception_with_message.dart';

class UserNotFound implements ExceptionWithMessage {
  final String userId;

  @override
  final String message;

  UserNotFound(this.userId)
      : message = 'User with specified ID ($userId) not found.';
}
