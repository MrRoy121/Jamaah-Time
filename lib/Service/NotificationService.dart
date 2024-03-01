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
    _convertToTime(DateTime(prayerTimes.asr!.year, prayerTimes.asr!.month, prayerTimes.asr!.day, 16, 51)),
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
    "Oh Allah, I ask you for knowledge that is of benefit, a good provision, and deeds that will be accepted.",
    "O Allah, give my soul (nafs) its God-fearing righteousness (taqwa) and purify it, for You are the best to purify it. You are its Protector and its Guardian.",
    "Our Lord! Grant us the good of this world and the Hereafter, and protect us from the torment of the Fire.",
    "O Allah! You have made my creation perfect, so make my moral characteristics also be the best.",
    "Our Lord! Grant unto us wives and offspring who will be the comfort of our eyes, and give us (the grace) to lead the righteous.",
    "My Lord, grant me from Yourself a good offspring. Indeed, You are the Hearer of supplication.",
    "Oh Allah! I seek refuge with You from worry and grief, from incapacity and laziness, from cowardice and miserliness, from being heavily in debt and from being overpowered by (other) men.",
    "Oh Allah! Grant me well-being in my body. Oh Allah! Grant me well-being in my hearing. Oh Allah! Grant me well-being in my sight. There is no true God but You.",
    "O Allah! The Rubb of mankind! Remove this disease and cure me! You are the Great Curer. There is no cure but through You, which leaves behind no disease.",
    "In the Name of Allah, I place my trust in Allah. There is no might nor power except with Allah.",
    "In the Name of Allah, with Whose Name nothing is harmed on earth nor in heaven, and He is the All-Hearing, the All-Knowing. [Repeat three times]",
    "Our Lord! Do not let our hearts deviate after you have guided us. Grant us Your mercy. You are indeed the Giver of all bounties.",
    "Allah is enough for me. There is no true god but Him, in Him I put my trust, an He is the Lord of the Great Throne. [Repeat seven times]",
    "I seek refuge in the Perfect Words of Allah from the evil of what He has created.",
    "O Allah, forgive all of my sins: the small and great, the first and the last, the public and the private.",
    "Oh Allah, make it a start full of peace and faith, safety and Islam. My Lord and your Lord is Allah.",


  ];

  final List<String> headings = [
    "Dua for knowledge",
    "Dua for taqwa",
    "Dua for success",
    "Dua for good character",
    "Dua for blessed family",
    "Dua for having children",
    "Dua for relief from distress, laziness, debts",
    "Dua for healthy body",
    "Dua for the sick",
    "Dua for guidance and protection before leaving the home",
    "Dua to avoid sudden afflictions",
    "Dua for preservation",
    "Dua that removes anxiety",
    "Dua for protection in the evening",
    "Dua for forgiveness of all sins",
    "When you see the new moon",

  ];

  final Random random = Random();

  final List<Time> notificationTimes = [
    Time(8, 0),
    Time(10, 0),
    Time(13, 0),
    Time(15, 0),
    Time(17, 0),

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