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

  final InitializationSettings initializationSettings =
  InitializationSettings(
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
  // print(prayerTimes.maghrib!.toLocal());

  // Function to add minutes to a DateTime object
  DateTime addMinutes(DateTime dateTime, int minutes) {
    return dateTime.add(Duration(minutes: minutes));
  }

  List<Time> notificationTimes = [
    _convertToTime(addMinutes(prayerTimes.fajr!.toLocal(), 15)),
    _convertToTime(addMinutes(prayerTimes.dhuhr!.toLocal(), 15)),
    _convertToTime(prayerTimes.asr!.toLocal()),
    // _convertToTime(DateTime(prayerTimes.asr!.year, prayerTimes.asr!.month, prayerTimes.asr!.day, 12, 53)),
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