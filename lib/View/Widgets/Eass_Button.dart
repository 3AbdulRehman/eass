import 'package:flutter/material.dart';

import '../../constant.dart';

class EassButton extends StatelessWidget {
  EassButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }
    return  Container(
      height: h * 0.055,
      width: w * 0.75,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              kButtonColor), // Change the color here
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(0.0), // Set this to 0.0
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(label,style: TextStyle(fontSize: responsiveTextSize(18),color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),),

      ),
    );
  }
}
