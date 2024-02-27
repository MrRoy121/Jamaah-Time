import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationHandler(this.flutterLocalNotificationsPlugin);

  Future<void> showCustomDailyNotification(
      int id,
      String title,
      String message,
      Time time,
      NotificationDetails platformChannelSpecifics,
      String payload,
      ) async {
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      id,
      title,
      message,
      time,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}