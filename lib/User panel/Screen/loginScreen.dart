// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:jamaah_time/User%20panel/Screen/signupScreen.dart';
// import 'package:jamaah_time/User%20panel/Screen/uShoping.dart';
//
// import '../../Constants/constant.dart';
// import '../e-shoping/shoping-navbar.dart';
//
//
// class SignInScreen extends StatefulWidget {
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   Future<void> signIn() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => ShopingNavbar()),
//       );
//     } catch (e) {
//       print('Error during sign in: $e');
//     }
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
//           "Jama'ah Time - SignIn",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 80),
//             child: Container(
//               color: Colors.white70,
//               padding: EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Image.asset('Assets/logo.png', width: 150, height: 150),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       prefixIcon: Icon(Icons.lock),
//                     ),
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       signIn();
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.green),
//                     ),
//                     child: Text(
//                       'Sign In',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Do not have an account?',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => SignUpScreen(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           ' Sign Up',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       )
//
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
