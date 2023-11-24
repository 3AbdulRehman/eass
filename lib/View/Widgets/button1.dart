import 'package:eass/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton1 extends StatelessWidget {
  const MyButton1({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 55,
      width: 310,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blue), // Change the color here
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(0.0), // Set this to 0.0
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            "Sign In",
            style: TextStyle(
                fontFamily: "RegularFonts",
                fontWeight: FontWeight.bold,
              color: kTextColor
                ),
          )),
    );

  }
}
