import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  const CardHome({super.key, required this.child});
  final Widget child;


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }

    return Container(
      child: child,
      height: h*0.16,
      width: w*0.31,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 2,
          )]
      ),
    );
  }
}
