import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_4/view/home_screen/home_screen.dart';
import 'package:test_4/view/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    validate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash\nScreen",
          style: TextStyle(
              color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

validate(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = await prefs.getString('user');
  String? pass = await prefs.getString('password');
  bool? isLoggedIn = await prefs.getBool('isLoggedIn');

  Timer(
    Duration(seconds: 2),
    () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ((name == null && pass == null) ||
                    (name == '' && pass == '') ||
                    isLoggedIn == false)
                ? LoginScreen()
                : HomeScreen(),
          ));
    },
  );
}
