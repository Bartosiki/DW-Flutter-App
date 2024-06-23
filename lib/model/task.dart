import 'package:dw_flutter_app/constants/firestore_fields.dart';

class Task {
  final String title;
  final String description;
  final int points;
  final String qrCode;
  bool isDone = false;

  Task({
    required this.title,
    required this.description,
    required this.points,
    required this.qrCode,
    this.isDone = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json[FirestoreTasksFields.title],
      description: json[FirestoreTasksFields.description],
      points: json[FirestoreTasksFields.points],
      qrCode: json[FirestoreTasksFields.qrCode],
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Task &&
            runtimeType == other.runtimeType &&
            title == other.title &&
            description == other.description &&
            points == other.points &&
            qrCode == other.qrCode;
  }

  @override
  int get hashCode => Object.hashAll(
        [
          title,
          description,
          points,
          qrCode,
        ],
      );
}
