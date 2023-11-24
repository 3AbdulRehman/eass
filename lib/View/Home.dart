import 'package:eass/View/admin_s/Drawer_Screen.dart';
import 'package:eass/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            Image.asset("assets/images/logo.png",
              height: h*0.2,
              width: w*0.2,
            ),
            SizedBox(width: w*0.03,),
            Text("EASS",style: TextStyle(fontSize: responsiveTextSize(20),fontWeight: FontWeight.bold),)
          ],
        ),
      ),

      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
