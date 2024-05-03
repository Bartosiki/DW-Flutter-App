import 'exception_with_message.dart';

class TaskAlreadyFinished implements ExceptionWithMessage {
  final String userId;
  final int taskId;
  final String qrCode;

  @override
  final String message;

  TaskAlreadyFinished(this.userId, this.taskId, this.qrCode)
      : message =
            'User (id: $userId) has already finished task (id: $taskId) with QR code ($qrCode).';
}
