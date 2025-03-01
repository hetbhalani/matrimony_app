import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:matrimonial_app/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for the animation to complete and navigate to the next screen
    Future.delayed(Duration(seconds: 3), () {
      // Replace with the actual screen after splash
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your main screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/imgs/heart-animation.json'),
      ),
    );
  }
}
