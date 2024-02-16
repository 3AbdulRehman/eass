import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/Controller/Admin%20Controller/Admin%20edit%20&%20Update%20Controller/admin_edit&update_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import 'edit_admin_Textfieldform.dart';



class EditAndUpdateAdmin extends StatefulWidget {
  const EditAndUpdateAdmin({super.key});

  @override
  State<EditAndUpdateAdmin> createState() => _EditAndUpdateAdminState();
}

class _EditAndUpdateAdminState extends State<EditAndUpdateAdmin> {

  
  
  final AdminEditController adminEditController = Get.put(AdminEditController());
  
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
        backgroundColor: kPrimaryColor.withOpacity(0.6),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/logo.png",
              height: h*0.25,
              width: w*0.25,
            ),
            SizedBox(width: w*0.001,),
            Text("Edit & Update Admin",style: TextStyle(fontSize: responsiveTextSize(20),fontWeight: FontWeight.bold),)
            //Text("Edit And Update Users")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Obx(() => adminEditController.isLoaded.value
                  ? DataTable(
                columns: [
                  DataColumn(label: Text('Name',style: TextStyle(fontFamily: "BoldFonts"),)),
                  DataColumn(label: Text('Designation',style: TextStyle(fontFamily: "BoldFonts",),)),
                  DataColumn(label: Text('Action',style: TextStyle(fontFamily: "BoldFonts",),)),

                  // Add more DataColumn widgets for additional fields
                ],
                rows: adminEditController.userData.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Text(user['name'] ?? 'N/A')),
                      DataCell(Text(user['designation'] ?? 'N/A')),

                      DataCell(Row(
                        children: [
                          GestureDetector(
                            child: Icon(Icons.edit,size: 20,),
                            onTap: (){
                              print('User data before navigating: $user');
                              if (user != null) {
                                Get.to(() => EditAdminTextFieldForm(user: user));
                              } else {
                                print('Error: User data not available for editing');
                              }

                            },
                          ),
                          SizedBox(width: w*0.03),
                          GestureDetector(
                            child: Icon(Icons.delete,size: 20,),
                            onTap: (){
                              adminEditController.deleteUser(user['userId']);

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





