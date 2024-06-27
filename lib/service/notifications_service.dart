import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../constants/firestore_collections.dart';
import '../constants/firestore_fields.dart';
import '../constants/notifications.dart';
import '../exceptions/user_not_found.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();

  PushNotificationService() {
    _initialize();
  }

  Future<void> _initialize() async {
    enableNotification();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotifications.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen(_onMessageReceived);

    saveDeviceToken();
  }

  Future<void> _onMessageReceived(RemoteMessage message) async {
    if (message.notification != null) {
      await _showNotification(message);
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Notifications.chanelId,
      Notifications.chanelName,
      channelDescription: Notifications.chanelDescription,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotifications.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  Future<void> saveDeviceToken() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userSnapshot = await FirebaseFirestore.instance
        .collection(FirestoreCollections.users)
        .where(FirestoreUsersFields.userId, isEqualTo: userId)
        .limit(1)
        .get();

    if (userSnapshot.docs.isEmpty) {
      throw UserNotFound(userId!);
    }

    final userDoc = userSnapshot.docs.first;

    String? token = await _firebaseMessaging.getToken();

    if (token != null) {
      await userDoc.reference.update(
        {
          FirestoreUsersFields.notificationToken: token,
        },
      );
    }
  }

  Future<void> enableNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
