import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future initialize() async {
    final DarwinInitializationSettings initializationSettingsDarwin =
    const DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    // var iOSInitialize = IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification({
    int notificationID = 0,
    required String channelID,
    required String channelName,
    required String title,
    required String body,
    var payload,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelID, channelName,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
      color: secondaryColor,
      styleInformation: const BigTextStyleInformation(''),
    );

    var not = NotificationDetails(
      android: androidPlatformChannelSpecifics,

      // iOS:
    );
    await flutterLocalNotificationsPlugin.show(
        notificationID, title, body, not);
  }



}

  void onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
 logger.d('notifications received');
}