import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jamaah_time/Constants/constant.dart';
import 'package:jamaah_time/User%20panel/Screen/Navbar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Navbar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: double.infinity,
          color: AppColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Assets/logo.png', width: 150, height: 150),
              SizedBox(height: 40),
              Text(
                "Jama'ah Time",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
