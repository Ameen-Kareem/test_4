import 'package:flutter/material.dart';
import 'package:test_4/view/splash_screen/splash_screen.dart';

void main() {
  runApp(AuthenticationApp());
}

class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
