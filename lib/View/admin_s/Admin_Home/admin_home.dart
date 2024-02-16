import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/View/Widgets/Eass_Button.dart';
import 'package:eass/View/admin_s/Add%20Users/eidt_update.dart';
import 'package:eass/View/admin_s/Admin%20Users/Admin_Database.dart';
import 'package:eass/View/admin_s/Admin%20Users/Edit_update_admin.dart';
import 'package:eass/View/admin_s/Admin_Home/mycard.dart';
import 'package:eass/View/admin_s/Add%20Users/user_database.dart';
import 'package:eass/View/admin_s/Add%20Users/add_users.dart';
import 'package:eass/View/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../Admin Users/add_admin.dart';
import '../admin_drawer.dart';

class Admin_Home extends StatefulWidget {
  const Admin_Home({super.key});

  @override
  State<Admin_Home> createState() => _Admin_HomeState();
}



class _Admin_HomeState extends State<Admin_Home> {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users');

  bool isLoading = true; // Flag to indicate whether data is still being fetched

  late int documentCount=0;
  Future<void> _fetchDocumentCount() async {
    try {
      QuerySnapshot querySnapshot = await _collectionRef.get();
      setState(() {
        documentCount = querySnapshot.docs.length;
        isLoading = false; // Set the flag to indicate data is ready
      });
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false; // Set the flag even in case of an error
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDocumentCount();
  }
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }
    return  Scaffold(
    //  drawer: Drawer_Screen(),
      drawer: Admin_Drawer(),
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
                             GestureDetector(
                                  child: Icon(Icons.logout,
                                    size: 32,
                                    color: Colors.white,),
                                  onTap: () async {
                                    try{
                                     await FirebaseAuth.instance.signOut();
                                      Get.offAll(SignIn());
                                    }catch (e){
                                      print("Error During Logout :$e");

                                    }

                                  },

                            ),
                            SizedBox(height: h*0.005,),
                            Text("Exam Attendance Student System",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: responsiveTextSize(17)),),
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
                              image:AssetImage('assets/images/logo.png')
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        //Image
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: MyCard(
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
                                    sectionsSpace: 2,
                                    centerSpaceRadius: 43,
                                    borderData: FlBorderData(show: false),
                                  sections: [
                                     PieChartSectionData(
                                    value: 40,color: Colors.green,title: "$documentCount",),
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
                                  Center(
                                    child: isLoading
                                        ? CircularProgressIndicator():
                                    Text('$documentCount',style: TextStyle(fontSize: 40,fontFamily: 'BoldFonts',fontWeight: FontWeight.bold),),

                                  ),
                                  SizedBox(height: 0.002,),
                                  Text("Total Students",
                                    style: TextStyle(fontSize: responsiveTextSize(17),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),
                                  ),
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
                                      Text(" Present Students",style: TextStyle(fontSize: responsiveTextSize(15)),),
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
                                      Text(" Absent Students",style: TextStyle(fontSize: responsiveTextSize(15)),),
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
                                                      boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.1))]
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
                                            Get.to(AddUsers());
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
                                                      boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.1))]
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
                                            Get.to(EditAndUpdate());

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
                                                      boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.1))]
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
                                            Get.to(UserDatabase());

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
                                                      boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.1))]
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
                                            Get.to(Add_Admin());

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
                                                      boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.1))]
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
                                            Get.to(EditAndUpdateAdmin());

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
                                                      boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.1))]
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
                                            Get.to(Admin_Database());

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
                  Get.to(SignIn());

                }),
                SizedBox(height: h*0.015,),
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

