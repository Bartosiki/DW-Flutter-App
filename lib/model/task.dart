import 'package:dw_flutter_app/constants/firestore_fields.dart';

class Task {
  final int taskId;
  final String title;
  final String description;
  final int points;
  final String qrCode;
  final String imageSrc;

  Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.points,
    required this.qrCode,
    required this.imageSrc,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json[FirestoreTasksFields.taskId],
      title: json[FirestoreTasksFields.title],
      description: json[FirestoreTasksFields.description],
      points: json[FirestoreTasksFields.points],
      qrCode: json[FirestoreTasksFields.qrCode],
      imageSrc: json[FirestoreTasksFields.imageSrc],
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Task &&
            runtimeType == other.runtimeType &&
            taskId == other.taskId &&
            title == other.title &&
            description == other.description &&
            points == other.points &&
            qrCode == other.qrCode &&
            imageSrc == other.imageSrc;
  }

  @override
  int get hashCode => Object.hashAll(
        [
          taskId,
          title,
          description,
          points,
          qrCode,
          imageSrc,
        ],
      );
}
