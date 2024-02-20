import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jamaah_time/Admin%20Panel/admin_navbar.dart';
import 'package:jamaah_time/Constants/constant.dart';
import 'package:jamaah_time/RegistationScreen.dart';

class AdminSignInScreen extends StatefulWidget {
  @override
  State<AdminSignInScreen> createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  signIn() {
    if (_emailController.text == "admin@admin.com" && _passwordController.text == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminNavbar()),
      );
    } else {
      print("login in failed");
    }
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              color: Colors.white70,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('Assets/logo.png', width: 150, height: 150),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       'Do not have an account?',
                  //       style: TextStyle(color: Colors.grey[600]),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => Registration(),
                  //           ),
                  //         );
                  //       },
                  //       child: Text(
                  //         ' Sign Up',
                  //         style: TextStyle(color: Colors.red),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
