import 'package:flutter/material.dart';
import 'package:jamaah_time/Constants/constant.dart';

class WaktoTime extends StatefulWidget {
  final String WakName;
  final String WakTime;

  WaktoTime({Key? key, required this.WakName, required this.WakTime}) : super(key: key);

  @override
  State<WaktoTime> createState() => _WaktoTimeState();
}

class _WaktoTimeState extends State<WaktoTime> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 90,
          height: 60,
          decoration: BoxDecoration(
            color: AppColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  widget.WakName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text(
                  widget.WakTime,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
