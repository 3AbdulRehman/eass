import 'package:eass/View/admin_s/Add%20Users/add_users.dart';
import 'package:eass/View/admin_s/Admin%20Users/add_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sign_in.dart';

class Admin_Drawer extends StatelessWidget {
  const Admin_Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }
    return Drawer(
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
                    Text('EASS System', style: TextStyle(fontWeight: FontWeight.bold,fontSize: responsiveTextSize(20))),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.admin_panel_settings_outlined),
              title: Text("Add Admins"),
              onTap: (){
                Get.to(Add_Admin());
              },
            ),
            ListTile(
              leading: Icon(Icons.people_alt),
              title: Text("Add Users"),
              onTap: (){
                Get.to(AddUsers());

              },
            ),
            ListTile(
              leading: Icon(Icons.sunny_snowing),
              title: Text("Theme Settings"),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.query_stats),
              title: Text("About This App"),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("Logout"),
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
        )

    );

  }
}
