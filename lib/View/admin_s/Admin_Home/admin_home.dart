import 'package:eass/View/Widgets/Eass_Button.dart';
import 'package:eass/View/admin_s/Admin_Home/mycard.dart';
import 'package:eass/View/admin_s/Drawer_Screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constant.dart';

class Admin_Home extends StatefulWidget {
  const Admin_Home({super.key});

  @override
  State<Admin_Home> createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }
    return  Scaffold(
    //  drawer: Drawer_Screen(),
      body: Stack(
        children: [
          HeaderBackground(
              screenHeight: h*1,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Exam Attendance Student System",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: responsiveTextSize(15)),),
                            SizedBox(height: h*0.002,),
                            Text("Dashboard",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: responsiveTextSize(25)),),

                          ],
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("https://scontent-mct1-1.xx.fbcdn.net/v/t39.30808-6/340765512_1904069496593959_8180849529892788408_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEU78WnvO0P0KCI5DVdd8t8G4JYhFLKhagbgliEUsqFqJTa4FRNJG97mQemoIyIMeFX-fy8dtiZlYutOe_XFv9G&_nc_ohc=VsUom7x7ZPIAX95z0Zx&_nc_ht=scontent-mct1-1.xx&oh=00_AfA96I-PYhQ7zL026duhxtqIon9wRBS1xB4X8u6RHm9tDw&oe=65651F7B")),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                MyCard(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                          right: 8,
                          bottom: 0,
                          child: Container(
                            //height: h*0.03,
                            width: w*0.45,
                            child: PieChart(
                              PieChartData(
                                startDegreeOffset: 0,
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 43,
                                  borderData: FlBorderData(show: false),
                                sections: [
                                  PieChartSectionData(
                                    value: 40,color: Colors.green,title: "120",),
                                  PieChartSectionData(
                                      value: 15,color: Colors.red,title: "17"),
                                  PieChartSectionData(
                                      value: 23,color: Colors.yellow,title: "50"),
                                ]
                              )
                            ),
                          )
                      ),
                      Positioned(
                        left: 16,
                          top: 15,
                          bottom: 0,
                          child: Container(
                            child: Column(
                              children: [
                                Text("120",style: TextStyle(fontSize: responsiveTextSize(50),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),),
                                SizedBox(height: 0.002,),
                                Text("Total Students",style: TextStyle(fontSize: responsiveTextSize(17),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),),
                                SizedBox(height: h*0.02,),
                                Row(
                                  children: [
                                    Container(
                                      height: h*0.015,
                                      width: w*0.03,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(16)
                                      ),
                                    ),SizedBox(height: h*0.01,),
                                    Text("  Leave Students",style: TextStyle(fontSize: responsiveTextSize(15)),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("50",style: TextStyle(fontSize: responsiveTextSize(30),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),),
                                  ],
                                ),
                                SizedBox(height: h*0.01,),
                                Row(
                                  children: [
                                    Container(
                                      height: h*0.015,
                                      width: w*0.03,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(16)
                                      ),
                                    ),SizedBox(height: h*0.01,),
                                    Text("  Absent Students",style: TextStyle(fontSize: responsiveTextSize(15)),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("17",style: TextStyle(fontSize: responsiveTextSize(30),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: MyCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: 5,bottom: 1),
                                    child: Text("User Management",style: TextStyle(fontSize: responsiveTextSize(20),fontWeight: FontWeight.bold,fontFamily: "BoldFonts",),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),

                                    child: Row(
                                      children: [

                                        GestureDetector(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Container(
                                                  height: h*0.09,
                                                  width: w*0.19,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [BoxShadow(color: Colors.black12)]
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(FontAwesomeIcons.userPlus,
                                                      color: kPrimaryColor,
                                                      size: 45,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text("Add Users",style: TextStyle(fontFamily: "BoldFonts",fontWeight: FontWeight.bold,fontSize: responsiveTextSize(15)),)
                                            ],
                                          ),
                                          onTap: (){

                                          },
                                        ),
                                        SizedBox(width: w*0.04),
                                        GestureDetector(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Container(
                                                  height: h*0.09,
                                                  width: w*0.19,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [BoxShadow(color: Colors.black12)]
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(FontAwesomeIcons.userEdit,
                                                      color: kPrimaryColor,
                                                      size: 45,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text("Edit/update",style: TextStyle(fontFamily: "BoldFonts",fontWeight: FontWeight.bold,fontSize: responsiveTextSize(15)),)
                                            ],
                                          ),
                                          onTap: (){

                                          },
                                        ),
                                        SizedBox(width: w*0.04),
                                        GestureDetector(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Container(
                                                  height: h*0.09,
                                                  width: w*0.19,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [BoxShadow(color: Colors.black12)]
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(FontAwesomeIcons.database,
                                                      color: kPrimaryColor,
                                                      size: 45,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text("Users Record",style: TextStyle(fontFamily: "BoldFonts",fontWeight: FontWeight.bold,fontSize: responsiveTextSize(15)),)
                                            ],
                                          ),
                                          onTap: (){

                                          },
                                        ),


                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3,bottom: 5),
                                    child: Text("Admin Management ",style: TextStyle(fontSize: responsiveTextSize(20),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Container(
                                                  height: h*0.09,
                                                  width: w*0.19,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [BoxShadow(color: Colors.black12)]
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(FontAwesomeIcons.userPlus,
                                                      color: kPrimaryColor,
                                                      size: 45,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text("Add Admin",style: TextStyle(fontFamily: "BoldFonts",fontWeight: FontWeight.bold,fontSize: responsiveTextSize(15)),)
                                            ],
                                          ),
                                          onTap: (){

                                          },
                                        ),
                                        SizedBox(width: w*0.04),
                                        GestureDetector(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Container(
                                                  height: h*0.09,
                                                  width: w*0.19,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [BoxShadow(color: Colors.black12)]
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(FontAwesomeIcons.userEdit,
                                                      color: kPrimaryColor,
                                                      size: 45,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text("Edit/Update",style: TextStyle(fontFamily: "BoldFonts",fontWeight: FontWeight.bold,fontSize: responsiveTextSize(15)),)
                                            ],
                                          ),
                                          onTap: (){

                                          },
                                        ),
                                        SizedBox(width: w*0.04),
                                        GestureDetector(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Container(
                                                  height: h*0.09,
                                                  width: w*0.19,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [BoxShadow(color: Colors.black12)]
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(FontAwesomeIcons.database,
                                                      color: kPrimaryColor,
                                                      size: 45,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text("Admin Record",style: TextStyle(fontFamily: "BoldFonts",fontWeight: FontWeight.bold,fontSize: responsiveTextSize(15)),)
                                            ],
                                          ),
                                          onTap: (){

                                          },
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),),
                        ],
                      )
                  ),
                ),
                SizedBox(height: h*0.07,),
                EassButton(label: "Lagout", onPressed: (){

                }),
              ],
            ),
          )

          
        ],
      ),



    );
  }
}

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({super.key, required this.screenHeight});

  final double screenHeight ;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: screenHeight*0.3,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32)
        )
      ),
    );
  }
}

