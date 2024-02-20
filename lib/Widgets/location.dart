// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:adhan_dart/adhan_dart.dart';
// import 'package:jamaah_time/Widgets/Prayertime.dart';
// import 'package:jamaah_time/Widgets/geoPosition.dart';
//
// class LocationFinder extends StatefulWidget {
//   const LocationFinder({Key? key}) : super(key: key);
//
//   @override
//   State<LocationFinder> createState() => _LocationFinderState();
// }
//
// class _LocationFinderState extends State<LocationFinder> {
//   Position? _currentPosition;
//   late StreamSubscription<Position> _positionStreamSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _positionStreamSubscription =
//         Geolocator.getPositionStream().listen((Position position) {
//           setState(() {
//             _currentPosition = position;
//           });
//         });
//   }
//
//   @override
//   void dispose() {
//     _positionStreamSubscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if (_currentPosition != null)
//               Expanded(
//                 child: PrayerTime(
//                   latitude: _currentPosition!.latitude,
//                   longitude: _currentPosition!.longitude,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
