class FirestoreConfigFields {
  static const String mainColor = 'mainColor';
  FirestoreConfigFields._();
}

class FirestoreEventsFields {
  static const String title = 'title';
  static const String description = 'description';
  static const String type = 'type';
  static const String room = 'room';
  static const String timeStart = 'timeStart';
  static const String timeEnd = 'timeEnd';
  static const String partner = 'partner';
  static const String category = 'category';
  FirestoreEventsFields._();
}

class FirestoreTasksFields {
  static const String taskId = 'taskId';
  static const String title = 'title';
  static const String description = 'description';
  static const String points = 'points';
  static const String qrCode = 'qrCode';
  static const String imageSrc = 'imageSrc';
  FirestoreTasksFields._();
}

class FirestoreUsersFields {
  static const String userId = 'userId';
  static const String displayName = 'displayName';
  static const String email = 'email';
  static const String finishedTasks = 'finishedTasks';
  static const String gainedPoints = 'gainedPoints';
  static const String isWinner = 'isWinner';
  static const String allowedNotifications = 'allowedNotifications';
  static const String lastScannedQrCodeTime = 'lastScannedQrCodeTime';
  FirestoreUsersFields._();
}

class FirestoreUserFinishedTaskFields {
  static const String taskId = 'taskId';
  static const String points = 'points';
  static const String qrCode = 'qrCode';
  static const String finishedAt = 'finishedAt';
  FirestoreUserFinishedTaskFields._();
}

class FirestorePatronsFields {
  static const String name = 'name';
  static const String imageSrc = 'imageSrc';
  FirestorePatronsFields._();
}

class FirestorePartnersFields {
  static const String name = 'name';
  static const String imageSrc = 'imageSrc';
  static const String package = 'package';
  FirestorePartnersFields._();
}

class FirestoreContestTimeFields {
  static const String endTime = 'endTime';
}
