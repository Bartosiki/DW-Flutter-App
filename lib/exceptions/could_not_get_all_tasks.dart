import 'exception_with_message.dart';

class CouldNotGetAllTasks implements ExceptionWithMessage {
  @override
  final String message;

  CouldNotGetAllTasks() : message = 'Could not get all tasks.';
}
