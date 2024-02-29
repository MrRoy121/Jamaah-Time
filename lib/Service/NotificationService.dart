import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:adhan_dart/adhan_dart.dart';

import 'PrayerTimeDateCoordinats.dart';

Future<void> scheduleDailyNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('ic_launcher');
  final IOSInitializationSettings iosInitializationSettings =
  IOSInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {
      // Handle notification tap
    },
  );

  PrayerTimes prayerTimes = await PrayerTimesUtil.getPrayerTimes();

  // Function to add minutes to a DateTime object
  DateTime addMinutes(DateTime dateTime, int minutes) {
    return dateTime.add(Duration(minutes: minutes));
  }

  List<Time> notificationTimes = [
    _convertToTime(addMinutes(prayerTimes.fajr!.toLocal(), 15)),
    _convertToTime(addMinutes(prayerTimes.dhuhr!.toLocal(), 15)),
    _convertToTime(prayerTimes.asr!.toLocal()),
    // _convertToTime(DateTime(prayerTimes.asr!.year, prayerTimes.asr!.month, prayerTimes.asr!.day, 15, 58)),
    _convertToTime(prayerTimes.maghrib!.toLocal()),
    _convertToTime(prayerTimes.isha!.toLocal()),
  ];

  for (int i = 0; i < notificationTimes.length; i++) {
    Time time = notificationTimes[i];

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      i,
      'Prayer Time Notification',
      'It\'s time for ${getPrayerName(i)} prayer!',
      time,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          'channel_description',
        ),
        iOS: IOSNotificationDetails(),
      ),
      payload: 'custom_payload_$i',
    );
  }

  // Schedule random notifications at specified times
  await scheduleRandomNotifications(flutterLocalNotificationsPlugin);
}

Time _convertToTime(DateTime? dateTime) {
  return Time(dateTime!.hour, dateTime.minute);
}

String getPrayerName(int index) {
  switch (index) {
    case 0:
      return 'Fajr';
    case 1:
      return 'Dhuhr';
    case 2:
      return 'Asr';
    case 3:
      return 'Maghrib';
    case 4:
      return 'Isha';
    default:
      return '';
  }
}

Future<void> scheduleRandomNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  final List<String> messages = [
    "1. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "2. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "3. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "4. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "5. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "6. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "7. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "8. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "9. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    "10. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
  ];

  final List<String> headings = [
    "heading1",
    "heading2",
    "heading3",
    "heading4",
    "heading5",
    "heading6",
    "heading7",
    "heading8",
    "heading9",
    "heading10",
  ];

  final Random random = Random();

  final List<Time> notificationTimes = [
    Time(15, 53),
    Time(15, 54),
    Time(15, 56),
  ];

  for (final Time time in notificationTimes) {
    final int randomIndex = random.nextInt(messages.length);
    final String selectedMessage = messages[randomIndex];
    final String selectedHeading = headings[randomIndex];

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      time.hashCode,
      selectedHeading,
      selectedMessage,
      time,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          'channel_description',
        ),
        iOS: IOSNotificationDetails(),
      ),
      payload: 'custom_payload_${time.hour}${time.minute}',
    );
  }
}
