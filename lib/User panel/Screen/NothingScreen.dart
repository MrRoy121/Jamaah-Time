import 'package:flutter/material.dart';

import '../../Constants/constant.dart';

class NothingScreen extends StatefulWidget {
  const NothingScreen({Key? key}) : super(key: key);

  @override
  State<NothingScreen> createState() => _NothingScreenState();
}

class _NothingScreenState extends State<NothingScreen> {
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
              SizedBox(height: 40),
              Text(
                "Need to permision for location!!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
