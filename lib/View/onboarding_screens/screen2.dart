import 'package:eass/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Screen_2 extends StatelessWidget {
  const Screen_2({super.key});

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
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/onboarding2.svg",
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
                "REAL-TIME DATA AT YOUR FINDERTIPS",
                style: TextStyle(
                  fontFamily: "BoldFonts",
                  fontSize: responsiveTextSize(20),
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
                "Real-Time Data with currency",
                style: TextStyle(
                  fontFamily: "RegularFonts",
                  fontSize: responsiveTextSize(18),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.0015,
            ),
            Center(
              child: Text(
                "Pairs, Commodity Prices and stock indices",
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
