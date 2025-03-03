import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jamaah_time/Constants/constant.dart';
import 'package:jamaah_time/SplashScreen.dart';
import 'package:jamaah_time/User%20panel/Screen/NothingScreen.dart';
import 'package:location/location.dart' as ss;
import 'package:permission_handler/permission_handler.dart';
import 'Service/NotificationService.dart';
// import 'Service/Dua_service.dart';
import 'User panel/Screen/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC8wcJxUuRX-2jdzoTYdbGkLdPjBjpruD4",
          authDomain: "jamaah-time-official.firebaseapp.com",
          projectId: "jamaah-time-official", //
          storageBucket: "jamaah-time-official.appspot.com", //
          messagingSenderId: "643686177046", //
          appId: "1:234434158054:android:499c2433f5d6a4c3654a27", //
          measurementId: "G-2SSBK8J986" //
      )
  );_fetchLocation();
  await scheduleDailyNotifications();
  // await scheduleRandomNotifications();
  runApp(const MyApp());
}

Future<void> _fetchLocation() async {
  ss.Location location = ss.Location();
  try {
    ss.LocationData locationData = await location.getLocation();
    print("Location: ${locationData.latitude}, ${locationData.longitude}");
  } catch (e) {
    print("Error fetching location: $e");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool hasPermission = false;

  Future getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        hasPermission = true;
      } else {
        Permission.location.request().then((value) {
          setState(() {
            hasPermission = (value == PermissionStatus.granted);
          });
        });
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor,

          )
      ),

      // home: SignInScreen(),
      // home: Navbar(),
      // home: SplashScreen(),
      home: FutureBuilder(
        builder: (context, snapshot) {
          if (hasPermission) {
            return SplashScreen();
            // return LocationFinder();
          } else {
            return NothingScreen();
          }
        },
        future: getPermission(),
      ),
    );
  }
}