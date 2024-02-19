import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/View/Widgets/EassPassTextfield.dart';
import 'package:eass/View/Widgets/Eass_Button.dart';
import 'package:eass/View/Widgets/EassemailTextfield.dart';
import 'package:eass/View/admin_s/Add%20Users/add_users.dart';
import 'package:eass/View/admin_s/Admin_Home/admin_home.dart';
import 'package:eass/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home/Home.dart';
import 'Widgets/Easstextfield.dart';

class SignIn extends StatefulWidget {
   SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController rollnumberController = TextEditingController();

  final TextEditingController passController = TextEditingController();
  @override
  void dispose() {
    rollnumberController.dispose();
    passController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
              key: _formKey,
              child: Column(
                children: [
                  EassTextField(labelText: "Enter Your ID", controller: rollnumberController, keyboardType: TextInputType.text,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "ID is Required";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: EassPassField(labelText: "Password",
                        controller: passController,
                      validator: (value){
                        if(value== null || value.isEmpty){
                          return "Pasword is required";
                        }else if(value.length < 8){
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: h * 0.04,
            ),
            EassButton(label: "Sign in", onPressed: (){
              if(_formKey.currentState!.validate()){
                _signIn();
              }

            }
            ),
            SizedBox(
              height: h * 0.04,
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
            SizedBox(height: h * 0.045,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Seamlessly Manage & Track with RFID System",style: TextStyle(fontSize: responsiveTextSize(13),fontFamily: 'RegularFonts',fontWeight: FontWeight.bold),),
                  SizedBox(width: w*0.002,),
                  GestureDetector(child: Text("Terms of Use",style: TextStyle(fontSize: responsiveTextSize(15),fontFamily: 'RegularFonts',fontWeight: FontWeight.bold,color: kPrimaryColor),),
                  onTap: (){},
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void _signIn() async {
    String idOrRollNumber = rollnumberController.text; // Assuming you have a controller for ID or roll number
    String pass = passController.text;

    // Hardcoded super admin credentials
    String superAdminIdOrRollNumber = 'admin123';
    String superAdminPassword = '12345678';

    try {
      // Attempt super admin authentication
      if (idOrRollNumber == superAdminIdOrRollNumber && pass == superAdminPassword) {
        // Login as super admin
        print("Super Admin Successfully Logged In");
        Get.to(Admin_Home());
        return;
      }

      // Attempt admin authentication
      QuerySnapshot adminSnapshot = await FirebaseFirestore.instance.collection('admins')
          .where('id', isEqualTo: idOrRollNumber)
          .where('password', isEqualTo: pass)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        // Login as admin
        print("Admin Successfully Logged In");
        Get.to(AddUsers());
        return;
      }


      // Attempt regular user authentication
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '$idOrRollNumber@gmail.com', // Use a dummy email with a unique domain
        password: pass,
      );

      User? user = userCredential.user;

      if (user != null) {
        print("User Successfully Logged In");
        Get.to(Home());
      }
    } catch (e) {
      print("Error logging in: $e");
      Get.snackbar("Error", "Invalid ID or Roll Number and Password",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}
