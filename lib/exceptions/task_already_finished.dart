import 'exception_with_message.dart';

class TaskAlreadyFinished implements ExceptionWithMessage {
  final String userId;
  final String qrCode;

  @override
  final String message;

  TaskAlreadyFinished(this.userId, this.qrCode)
      : message =
            'User (id: $userId) has already finished task with QR code ($qrCode).';
}
