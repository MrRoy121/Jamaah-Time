// Import statements
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../LoginScreen.dart';
import '../../Widgets/waktoTime.dart';

// HomeScreen class
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List months = [
  "Jan", "Feb", "Mar", "Apl", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"
];

// _HomeScreenState class
class _HomeScreenState extends State<HomeScreen> {

  Position? _currentPosition;
  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
          setState(() {
            _currentPosition = position;
          });
        });
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  String timePresenter(DateTime dateTime){
    String timeInString = "";
    bool isGreaterThen12 = dateTime.hour > 12;
    String prefix = dateTime.hour > 11 ? "pm" : "am";
    int hour = isGreaterThen12 ? dateTime.hour - 12 : dateTime.hour;
    int minute = dateTime.minute;

    return "$hour : $minute $prefix";
  }

  @override
  Widget build(BuildContext context) {

    Coordinates coordinates = _currentPosition != null
        ? Coordinates(
        _currentPosition!.latitude.toDouble(),
        _currentPosition!.longitude.toDouble())
        : Coordinates(0.0, 0.0);
    DateTime date = DateTime.now();
    CalculationParameters params = CalculationMethod.Dubai();
    PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params, precision: true);

    return LayoutBuilder(builder: (context, constraints){
      final height = constraints.maxHeight;
      final width = constraints.maxHeight;

      return Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'Assets/logo.png',
            width: 10,
            height: 10,
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "Jama'ah Time",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.security, color: Colors.white,),
                onPressed: () {
                  // Admin panel
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminSignInScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),


        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(
                      "Today's Namaz Time",
                      style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${date.day} ${months[date.month-1]} ${date.year}".toString(),
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lat. ${coordinates.latitude}, ",
                          style: TextStyle(color: Color(0xFF1388be), fontSize: 12),
                        ),
                        Text(
                          "Lan. ${coordinates.longitude}",
                          style: TextStyle(color: Color(0xFF1388be), fontSize: 12),
                        )
                      ],
                    ),
                    Text(
                      "Local Timezone: ${DateTime.now().timeZoneName}",
                      style: TextStyle(
                        color: Colors.black, fontSize: 20,
                      ),
                    ),

                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: height*0.03,),
                    // Text("Fajr Time: ${timePresenter(prayerTimes.fajr!.toLocal())}"),
                    WaktoTime(
                        WakName: 'Fajr',
                        WakTime: timePresenter(prayerTimes.fajr!.toLocal())
                      // "${prayerTimes.maghrib!.toLocal().hour}:${prayerTimes.maghrib!.toLocal().minute}",
                    ),
                    SizedBox(height: height*0.03,),
                    WaktoTime(
                        WakName: 'Zuhr',
                        WakTime: timePresenter(prayerTimes.dhuhr!.toLocal())
                      // "${prayerTimes.maghrib!.toLocal().hour}:${prayerTimes.maghrib!.toLocal().minute}",
                    ),
                    // Text("Zuhr Time: ${timePresenter(prayerTimes.dhuhr!.toLocal())}"),
                    SizedBox(height: height*0.03,),
                    WaktoTime(
                        WakName: 'Asr',
                        WakTime: timePresenter(prayerTimes.asr!.toLocal())
                      // "${prayerTimes.maghrib!.toLocal().hour}:${prayerTimes.maghrib!.toLocal().minute}",
                    ),
                    // Text("Asr Time: ${timePresenter(prayerTimes.asr!.toLocal())}"),
                    SizedBox(height: height*0.03,),
                    WaktoTime(
                        WakName: 'Maghrib',
                        WakTime: timePresenter(prayerTimes.maghrib!.toLocal())
                      // "${prayerTimes.maghrib!.toLocal().hour}:${prayerTimes.maghrib!.toLocal().minute}",
                    ),
                    // Text("Maghrib Time: ${timePresenter(prayerTimes.maghrib!.toLocal())}"),
                    SizedBox(height: height*0.03,),
                    WaktoTime(
                        WakName: 'Isha',
                        WakTime: timePresenter(prayerTimes.isha!.toLocal())
                      // "${prayerTimes.maghrib!.toLocal().hour}:${prayerTimes.maghrib!.toLocal().minute}",
                    ),
                    // Text("Isha Time: ${timePresenter(prayerTimes.isha!.toLocal())}"),
                    SizedBox(height: height*0.03,),

                  ],
                )
              ],
            ),
          ),
        ),

      );
    },
    );
  }
}
