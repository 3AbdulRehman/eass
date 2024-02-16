import 'package:eass/View/Home/Home.dart';
import 'package:eass/View/onboarding_screens/screen1.dart';
import 'package:eass/View/onboarding_screens/screen2.dart';
import 'package:eass/View/onboarding_screens/screen3.dart';
import 'package:eass/View/sign_in.dart';
import 'package:eass/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../main.dart';

class Onboarding extends StatefulWidget {
  Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _controller = PageController();

  //keep track of if we are on the last page or not
  bool onLastPage = false;
  Future setScreenOnboard()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    seenOnboard = await pref.setBool("seenOnboard", true);
    //this will set seenOnboard to true ,when screen running onboard page for first time.
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setScreenOnboard();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Screen_1(),
              Screen_2(),
              Screen_3(),
            ],
          ),
          Container(
            alignment: Alignment(0, .80),
            child: Padding(
              padding: EdgeInsets.only(top: 450),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    onLastPage
                        ? GestureDetector(
                            onTap: () {
                              Get.to(SignIn());
                            },
                            child: Container(
                                color: kButtonColor,
                                height: h*0.048,
                                width: w*0.6,
                                child: Center(
                                  child: Text(
                                    "Start Exploring",
                                    style: TextStyle(
                                        fontFamily: "FontsForex",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )),
                          )
                        : GestureDetector(
                            onTap: () {
                              _controller.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: Container(
                                color: kButtonColor,
                                height: h*0.048,
                                width: w*0.6,
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontFamily: "FontsForex",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                    SizedBox(
                      height: h * 0.009,
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 3,
                        dotWidth: 4, // For WormEffect, you can also set the dotWidth to control the size.
                        dotHeight: 4,
                        activeDotColor: kTextColor,
                      ),

                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
