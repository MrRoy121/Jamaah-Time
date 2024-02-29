// import 'dart:math';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// Future<void> scheduleRandomNotifications() async {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   const AndroidInitializationSettings androidInitializationSettings =
//   AndroidInitializationSettings('ic_launcher');
//   final IOSInitializationSettings iosInitializationSettings =
//   IOSInitializationSettings();
//
//   final InitializationSettings initializationSettings =
//   InitializationSettings(
//     android: androidInitializationSettings,
//     iOS: iosInitializationSettings,
//   );
//
//   try {
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: (String? payload) async {
//         // Handle notification tap
//       },
//     );
//
//     const List<String> messages = [
//       "1. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "2. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "3. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "4. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "5. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "6. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "7. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "8. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "9. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//       "10. Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
//     ];
//
//     const List<String> headings = [
//       "heading1",
//       "heading2",
//       "heading3",
//       "heading4",
//       "heading5",
//       "heading6",
//       "heading7",
//       "heading8",
//       "heading9",
//       "heading10",
//     ];
//
//     final Random random = Random();
//
//     final List<Time> notificationTimes = [
//       const Time(3, 49),
//       const Time(3, 50),
//       const Time(3, 41),
//     ];
//
//     for (final Time time in notificationTimes) {
//       final int randomIndex = random.nextInt(messages.length);
//       final String selectedMessage = messages[randomIndex];
//       final String selectedHeading = headings[randomIndex];
//
//       await flutterLocalNotificationsPlugin.showDailyAtTime(
//         time.hashCode,
//         selectedHeading,
//         selectedMessage,
//         Time(time.hour % 12, time.minute),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'channel_id',
//             'channel_name',
//             'channel_description',
//           ),
//           iOS: IOSNotificationDetails(),
//         ),
//         payload: 'custom_payload_${time.hour}${time.minute}',
//       );
//     }
//   } catch (e) {
//     print('Error scheduling notifications: $e');
//   }
// }
