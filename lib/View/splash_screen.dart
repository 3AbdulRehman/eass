import 'dart:async';
import 'package:eass/View/onboarding_screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Get.to(Onboarding()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  height: h * 0.3,
                  width: w * 0.3,
                ), // Your company logo in the center
              ],
            ),
          ),
          Positioned(
            left: 5, // Adjust the left position as needed
            bottom: 1, // Adjust the bottom position as needed
            child: Image.asset(
              'assets/images/splash_logo.png',
              height: h * 0.25,
              width: w * 0.5,
            ), // Your second image at the bottom left
          ),
        ],
      ),
    );
  }
}
