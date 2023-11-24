import 'dart:ui';

import 'package:eass/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Screen_1 extends StatelessWidget {
  const Screen_1({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/onboarding1.svg",
                  width: 250, // Adjust width and height as needed
                  height: 250,
                ),
              ),
            ),
            SizedBox(
              height: h * 0.10,
            ),
            Center(
              child: Text(
                "AFFORDABLE & SECURE",
                style: TextStyle(
                  fontFamily: "BoldFonts",
                  fontSize:responsiveTextSize(18),
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Center(
              child: Text(
                "Get live data at minimal charges\n    with safe and secure access",
                style: TextStyle(
                  fontFamily: "RegularFonts",
                  fontSize: responsiveTextSize(18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
