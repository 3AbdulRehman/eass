

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/View/Widgets/Easstextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Widgets/Eass_Button.dart';

class EditAdminTextFieldForm extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditAdminTextFieldForm({Key? key, required this.user}) : super(key: key);


  @override
  State<EditAdminTextFieldForm> createState() => _EditAdminTextFieldFormState();
}

class _EditAdminTextFieldFormState extends State<EditAdminTextFieldForm> {



  TextEditingController nameController = TextEditingController();
  TextEditingController ContactController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController designationController =  TextEditingController();
  TextEditingController PassController = TextEditingController();

  void _updateUserData(String userId) async {
    try {
      if (userId != null) {
        await FirebaseFirestore.instance.collection('admins').doc(userId).update({
          'name': nameController.text,
          'Number': ContactController.text,
          'id': idController.text,
          'designation': designationController.text,
        });
        print('User data updated successfully');
        Get.snackbar("successfully", "User data updated successfully",
          snackPosition: SnackPosition.BOTTOM
        );
      } else {
        print('Error: User ID is null');
        Get.snackbar("Error", "User ID is null",
            snackPosition: SnackPosition.BOTTOM
        );
      }
    } catch (e) {
      print("Error updating user data: $e");
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM
      );

    }
  }


  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.user['name']?.toString() ?? '';
    ContactController.text = widget.user['Number']?.toString() ?? '';
    idController.text = widget.user['id']?.toString() ?? '';
    designationController.text = widget.user['designation']?.toString() ?? '';

  }
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }


    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Lottie.asset('assets/images/Animation - 1702660127762.json',),
            ),
            SizedBox(height: h*0.022,),
            Column(
              children: [
                EassTextField(labelText: " Name", controller: nameController, keyboardType: TextInputType.text,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Name is Required";
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: h*0.022,),
                EassTextField(labelText: "Contact Number", controller: ContactController, keyboardType: TextInputType.text,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Contact Number is Required";
                    }else{
                      return null;
                    }
                  },
                ),

                SizedBox(height: h*0.022,),
                EassTextField(labelText: "ID ",
                  controller: idController, keyboardType: TextInputType.text,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "ID is Required";
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: h*0.022,),
                EassTextField(labelText: "Designation", controller: designationController, keyboardType: TextInputType.text,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Designation is Required";
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: h*0.022,),

              ],
            ),
            SizedBox(height: h * 0.08),

            EassButton(label: "Update", onPressed: (){
              _updateUserData(widget.user['userID']); // Assuming you have a unique identifier for each user
/*
*/
            }),
            SizedBox(height: h * 0.02),



          ],
        ),
      ),

    );
  }
}
