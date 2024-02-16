import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import '../sign_in.dart';

class Home_Drawer extends StatefulWidget {
  const Home_Drawer({super.key});

  @override
  State<Home_Drawer> createState() => _Home_DrawerState();
}

class _Home_DrawerState extends State<Home_Drawer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }
    return  Drawer(
      child: Container(
        height: double.infinity,
        width:  double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                kTextColor.withOpacity(0.7),
                Colors.cyanAccent.withOpacity(0.9),
              ]
          ),
        ),
        child: ListView(
          children: [
            Container(
              color: Colors.transparent, // Transparent background
              height: 200, // Maximum height for the logo
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo.png",
                      height: h*0.17,width: w*0.4,
                    ),
                    SizedBox(height: 10),
                    Text('EASS System', style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'BoldFonts',fontSize: responsiveTextSize(20),color: Colors.white)),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.fiber_smart_record_outlined,color: Colors.white),
              title: Text("Exam Record",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: responsiveTextSize(18)),),
              onTap: (){
              },
            ),
            /*ListTile(
              leading: Icon(Icons.people_alt),
              title: Text("Print"),
              onTap: (){

              },
            ),*/
            ListTile(
              leading: Icon(Icons.sunny_snowing,color: Colors.white,),
              title: Text("Theme Settings",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: responsiveTextSize(18)),),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.query_stats,color: Colors.white),
              title: Text("About This App",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: responsiveTextSize(18)),),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined,color: Colors.white,),
              title: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: responsiveTextSize(18)),),
              onTap: ()async {
                try{
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(SignIn());

                } catch(e){
                  print("Error During Logout :$e");
                }

              },
            ),



          ],
        ),
      ),
    );
  }
}
