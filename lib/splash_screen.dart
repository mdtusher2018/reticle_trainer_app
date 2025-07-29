import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_page.dart'; // navigate to onboarding after splash

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();
  // final now = DateTime.now();
  // final expiryDate = DateTime(2025, 7, 30); // July 30, 2025
  // if (now.isBefore(expiryDate)) {
  // } else {
  //   // If expired, go to expiration screen
  //   Timer(Duration(seconds: 3), () {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => ExpiredPage()),
  //     );
  //   });
  // }
      Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingPage()),
      );
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/logo.png', // put your logo in assets/images
        ),
      ),
    );
  }
}


class ExpiredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'This demo has expired.\nPlease contact the developer for more information.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      ),
    );
  }
}