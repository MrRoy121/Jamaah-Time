// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:jamaah_time/User%20panel/Screen/uShoping.dart';
//
// import '../../Constants/constant.dart';
// import '../e-shoping/shoping-navbar.dart';
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//
//   Future<void> signUp() async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//
//
//
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'name': _nameController.text,
//         'email': _emailController.text,
//         'phoneNumber': _phoneNumberController.text,
//         'address': _addressController.text,
//       });
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => ShopingNavbar()),
//       );
//     } catch (e) {
//       print('Error during sign up: $e');
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Sign Up',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: AppColor,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 50),
//             child: Container(
//               color: Colors.white70,
//               padding: EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   TextField(
//                     controller: _nameController,
//                     decoration: InputDecoration(
//                       labelText: 'Name',
//                       prefixIcon: Icon(Icons.person),
//                     ),
//                   ),
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
//                     controller: _phoneNumberController,
//                     decoration: InputDecoration(
//                       labelText: 'Phone Number',
//                       prefixIcon: Icon(Icons.phone),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: _addressController,
//                     decoration: InputDecoration(
//                       labelText: 'Address',
//                       prefixIcon: Icon(Icons.location_on),
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
//                       signUp();
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.green),
//                     ),
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
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
