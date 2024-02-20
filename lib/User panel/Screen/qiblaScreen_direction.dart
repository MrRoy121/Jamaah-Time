import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblaDirection extends StatefulWidget {
  const QiblaDirection({super.key});

  @override
  State<QiblaDirection> createState() => _QiblaDirectionState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblaDirectionState extends State<QiblaDirection> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'Assets/logo.png',
          width: 10,
          height: 10,
        ),
        title: Text(
          "Jama'ah Time",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      // backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      backgroundColor: Colors.black38,
      body: StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(alignment: Alignment.center, child: const CircularProgressIndicator(color: Colors.white,));
          }

          final qiblahDirection = snapshot.data;
          animation = Tween(begin: begin, end: (qiblahDirection!.qiblah * (pi / 180) * -1)).animate(_animationController!);
          begin = (qiblahDirection.qiblah * (pi / 180) * -1);
          _animationController!.forward(from: 0);

          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${qiblahDirection.direction.toInt()}°",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 300,
                      child: AnimatedBuilder(
                        animation: animation!,
                        builder: (context, child) => Transform.rotate(
                            angle: animation!.value,
                            child: Image.asset('Assets/qibla.png')),
                      ))
                ]),
          );
        },
      ),
    );
  }
}

// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_qiblah/flutter_qiblah.dart';
//
// class QiblaDirection extends StatefulWidget {
//   const QiblaDirection({super.key});
//
//   @override
//   State<QiblaDirection> createState() => _QiblaDirectionState();
// }
//
// Animation<double>? animation;
// AnimationController? _animationController;
// double begin = 0.0;
//
// class _QiblaDirectionState extends State<QiblaDirection>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     _animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 500));
//     animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Image.asset(
//           'Assets/logo.png',
//           width: 10,
//           height: 10,
//         ),
//         title: Text(
//           "Jama'ah Time",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FlutterQiblah.qiblahStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Container(
//               alignment: Alignment.center,
//               child: const CircularProgressIndicator(
//                 color: Colors.grey,
//               ),
//             );
//           }
//
//           final qiblahDirection = snapshot.data;
//           animation = Tween(
//             begin: begin,
//             end: (qiblahDirection!.qiblah * (pi / 180) * -1),
//           ).animate(_animationController!);
//           begin = (qiblahDirection.qiblah * (pi / 180) * -1);
//           _animationController!.forward(from: 0);
//
//           return Center(
//             child: SizedBox(
//               child: AnimatedBuilder(
//                 animation: animation!,
//                 builder: (context, child) => Transform.rotate(
//                   angle: animation!.value,
//                   child: Image.asset(
//                     'Assets/qibla_image.png',
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }