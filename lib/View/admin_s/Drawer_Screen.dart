import 'package:flutter/material.dart';

class Drawer_Screen extends StatelessWidget {
  const Drawer_Screen({super.key});

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
                    Text('Abdul Rehman', style: TextStyle(fontWeight: FontWeight.bold,fontSize: responsiveTextSize(20))),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.pan_tool_rounded),
              title: Text("Add Users"),
              onTap: (){},
            ),

            ListTile(
              leading: Icon(Icons.notifications_active),
              title: Text("Students Record"),
              onTap: (){},
            ),

            ListTile(
              leading: Icon(Icons.pan_tool_rounded),
              title: Text("Theme Settings"),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.query_stats),
              title: Text("About This App"),
              onTap: (){

              },
            ),

            ListTile(
              leading: Icon(Icons.query_stats_outlined),
              title: Text("Disclaimer"),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("Logout"),
              onTap: (){},
            ),



          ],
        )

    );

  }
}
