import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jamaah_time/Admin%20Panel/admin_navbar.dart';
import 'package:jamaah_time/Admin%20Panel/mosque_info_input.dart';
import 'package:jamaah_time/Constants/constant.dart';
import 'package:jamaah_time/LoginScreen.dart';
import 'package:jamaah_time/SplashScreen.dart';
import 'package:jamaah_time/User%20panel/Screen/Navbar.dart';
import 'package:jamaah_time/User%20panel/Screen/NothingScreen.dart';
import 'package:jamaah_time/Widgets/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'User panel/Screen/homescreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
  );
  tz.initializeTimeZones();
  runApp(const MyApp());
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
