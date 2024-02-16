import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../constant.dart';
import '../../Widgets/EassPassTextfield.dart';
import '../../Widgets/Eass_Button.dart';
import '../../Widgets/Easstextfield.dart';
import '../../sign_in.dart';

class Add_Admin extends StatefulWidget {
  const Add_Admin({super.key});

  @override
  State<Add_Admin> createState() => _Add_AdminState();
}

class _Add_AdminState extends State<Add_Admin> {

  final _formfield = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ContactController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController designationController =  TextEditingController();
  TextEditingController PassController = TextEditingController();




  // Firebase
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addAdminToFirestore() async {
    try {

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: "${idController.text}@gmail.com", // Use a dummy email with a unique domain
        password: PassController.text,
      );


      // Create a map with the user data
      Map<String, dynamic> userData = {
        'name': nameController.text.trim(),
        'id': idController.text.trim(),
        'Number': ContactController.text.trim(),
        'password': PassController.text.trim(),
        'designation': designationController.text.trim(),
        'userID': userCredential.user!.uid ,
      };
      // Add the user data to the 'forex' collection
      await firestore.collection('admins').doc(userCredential.user!.uid).set(userData);

      // Print a success message
      print('User added to Firestore successfully!');
      // Show SnackBar after successful data storage
      _showDialogBox();


      // Clear text fields
      nameController.clear();
      idController.clear();
      ContactController.clear();
      PassController.clear();
      designationController.clear();

    } catch (e) {
      // Print an error message if something goes wrong
      print('Error adding user to Firestore: $e');
      ErrorshowDialogBox('$e');

    }
  }

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Add Admin",style: TextStyle(fontSize: responsiveTextSize(25),fontWeight: FontWeight.bold),),
            SizedBox(width: w*0.001,),
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


            //Text("Edit And Update Users")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Lottie.asset('assets/images/Animation - 1702660127762.json',),
            ),
            SizedBox(height: h*0.022,),
            Form(
                key: _formfield,
                child: Column(
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
                    EassPassField(labelText: "Password", controller: PassController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Pasword is required";
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),

                  ],
                ),

            ),
            SizedBox(height: h * 0.08),

            EassButton(label: "Registor", onPressed: (){
              if(_formfield.currentState!.validate()){
                _addAdminToFirestore();

              }

            }),
            SizedBox(height: h * 0.02),



          ],
        ),
      ),




    );
    }
  void _showDialogBox(){
    Get.snackbar("successfully ", "Admin successfully added to Firestore!",
        snackPosition: SnackPosition.BOTTOM);
  }
  void ErrorshowDialogBox(String message) {
    Get.snackbar("Error", message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

}
