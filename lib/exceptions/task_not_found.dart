import 'exception_with_message.dart';

class TaskNotFound implements ExceptionWithMessage {
  final String qrCode;

  @override
  final String message;

  TaskNotFound(this.qrCode)
      : message = 'Task with specified QR code ($qrCode) not found.';
}
