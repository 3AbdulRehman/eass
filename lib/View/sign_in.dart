import 'package:eass/View/Widgets/EassPassTextfield.dart';
import 'package:eass/View/Widgets/Eass_Button.dart';
import 'package:eass/View/Widgets/EassemailTextfield.dart';
import 'package:eass/View/admin_s/Admin_Home/admin_home.dart';
import 'package:eass/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home.dart';

class SignIn extends StatelessWidget {
   SignIn({super.key});

  final TextEditingController emailController = TextEditingController();
   final TextEditingController passController = TextEditingController();


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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: h * 0.35,
                  width: w * 15,
                ),
              ),
            ),
            Center(
              child: Text("Welcome to the Exam Attences\n   Students System Using RFID",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                  fontFamily: "RegularFonts"
                ),),
            ),
          
            SizedBox(
              height: h * 0.05,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontFamily: "BoldFonts",
                        fontSize: 30,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Form(
              child: Column(
                children: [
                  EassEmaiTextField(
                      labelText: "Email",
                      controller: emailController,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    }
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  EassPassField(labelText: "Password",
                      controller: passController,
                    validator: (value){
                      if(value== null || value.isEmpty){
                        return "Pasword is required";
                      }else if(value.length < 8){
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: h * 0.04,
            ),
            EassButton(label: "Sign in", onPressed: (){
              Get.offAll(Admin_Home());

            }
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Center(
              child: Text(
                "Forget Password",
                style: TextStyle(
                    fontFamily: "RegularFonts",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: h * 0.02,),
            Center(
              child: RichText(
                text: TextSpan(
                    text: "Seamlessly manage and track with our RFID System ",
                    style: TextStyle(
                        fontFamily: 'RegularFonts',
                        fontSize: responsiveTextSize(13),
                        color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                    children: [
                      TextSpan(
                        text: "Terms of use",
                        style: TextStyle(
                          fontFamily: 'RegularFonts',
                          fontSize: responsiveTextSize(13),
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
