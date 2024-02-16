import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/Controller/User%20Controller/User%20Edit&%20Update%20View/user_edit_updateController.dart';
import 'package:eass/View/admin_s/Add%20Users/edit_user_textfieldform.dart';
import 'package:eass/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditAndUpdate extends StatefulWidget {
  const EditAndUpdate({super.key});

  @override
  State<EditAndUpdate> createState() => _EditAndUpdateState();
}
class _EditAndUpdateState extends State<EditAndUpdate> {

  UserController userController = Get.put(UserController());
    @override
    Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor.withOpacity(0.6),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/logo.png",
              height: h*0.25,
              width: w*0.25,
            ),
            SizedBox(width: w*0.001,),
            Text("Edit & Update Users",style: TextStyle(fontSize: responsiveTextSize(20),fontWeight: FontWeight.bold),) //Text("Edit And Update Users")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Obx(
                  ()=>userController.isLoaded.value

                      ? DataTable(
                    columns: [
                      DataColumn(label: Text('Name',style: TextStyle(fontFamily: "BoldFonts",fontSize: responsiveTextSize(15)),)),
                      DataColumn(label: Text('Roll Number',style: TextStyle(fontFamily: "BoldFonts",fontSize: responsiveTextSize(15),),)),
                      DataColumn(label: Text('Action',style: TextStyle(fontFamily: "BoldFonts",),)),

                      // Add more DataColumn widgets for additional fields
                    ],
                    rows: userController.userData.map((user) {
                      return DataRow(
                        cells: [
                          DataCell(Text(user['name'] ?? 'N/A')),
                          DataCell(Text(user['rollNumber'] ?? 'N/A')),

                          DataCell(Row(
                            children: [
                              GestureDetector(
                                child: Icon(Icons.edit,size: 20,),
                                onTap: (){
                                  print('User data before navigating: $user');
                                  if (user != null) {
                                    Get.to(() => EditUserTextFormField(user: user));
                                  } else {
                                    print('Error: User data not available for editing');
                                  }

                                },
                              ),
                              SizedBox(width: w*0.03),
                              GestureDetector(
                                child: Icon(Icons.delete,size: 20,),
                                onTap: (){
                                  userController.deleteUser(user['userID']);

                                },
                              ),
                            ],
                          )),
                          // Add more DataCell widgets for additional fields
                        ],
                      );
                    }).toList(),
                  )
                      : CircularProgressIndicator(),

              ),
            ),


          ],
        ),
      ),

    );
  }
}
