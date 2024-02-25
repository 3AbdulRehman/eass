import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:eass/View/sign_in.dart';
import 'package:eass/Model/Real-Time Card Value, Date & Time/card_value.dart';
import 'package:eass/constant.dart';
import 'package:eass/View/Widgets/EassPassTextfield.dart';
import 'package:eass/View/Widgets/Eass_Button.dart';
import '../Model/Add_FirstoreService.dart';
import '../Model/GoogleSheet/GoogleSheetClass.dart'; // Import FirebaseServices

class AddStudents extends StatefulWidget {
  const AddStudents({Key? key}) : super(key: key);

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  TextEditingController passController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  final CardValue cardValue = Get.put(CardValue());
  final FirebaseServices _firebaseServices = FirebaseServices(); // Instance of FirebaseServices

  void _searchStudent() async {
    String rollNo = rollNoController.text;
    if (rollNo.isEmpty) {
      return;
    }
    Map<String, dynamic>? student = await StudentRecordsSheet.getById(rollNo);
    if (student != null) {
      nameController.text = student['Name'];
      departmentController.text = student['Department'];
      semesterController.text = student['Semester'];
      // Populate paper values from student data
    } else {
      // Handle if student not found
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Student not found!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    cardValue.fetchCardValue();
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      return fontSize * (w / 414); // 414 is a reference screen width
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor.withOpacity(0.6),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Student Registration",
              style: TextStyle(
                fontSize: responsiveTextSize(22),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              child: Icon(
                Icons.logout,
                size: 25,
                color: Colors.white,
              ),
              onTap: () async {
                try {
                  // Handle sign out
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(SignIn());
                } catch (e) {
                  print("Error During Logout :$e");
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Lottie.asset('assets/images/Animation - 1702660127762.json'),
            ),
            SizedBox(height: h * 0.022),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                child: Column(
                  children: [
                    Center(
                      child: GetX<CardValue>(
                        init: cardValue,
                        builder: (controller) {
                          return Text(
                            "Card UID:  " + controller.value.value,
                            style: TextStyle(
                              fontFamily: "BoldFonts",
                              fontWeight: FontWeight.bold,
                              fontSize: responsiveTextSize(20),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: h * 0.022),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: rollNoController,
                            decoration: InputDecoration(labelText: 'Enter the Roll No'),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.flip_camera_android_outlined, size: 25, color: kTextColor),
                          onTap: _searchStudent,
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.002),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      readOnly: true,
                    ),
                    SizedBox(height: h * 0.002),
                    TextField(
                      controller: departmentController,
                      decoration: InputDecoration(labelText: 'Department'),
                      readOnly: true,
                    ),
                    SizedBox(height: h * 0.002),
                    TextField(
                      controller: semesterController,
                      decoration: InputDecoration(labelText: 'Semester'),
                      readOnly: true,
                    ),
                    SizedBox(height: h * 0.002),
                    EassPassField(labelText: 'Password', controller: passController),
                    SizedBox(height: h * 0.022),
                  ],
                ),
              ),
            ),
            EassButton(
              label: "Register",
              onPressed: () async {
                String rollNo = rollNoController.text;
                String password = passController.text;

                if (rollNo.isEmpty || password.isEmpty) {
                  // Check if any field is empty
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please fill all fields'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                // Register user with email and password
                User? user = await _firebaseServices.createUserWithEmailAndPassword(rollNo, password);
                if (user != null) {
                  // Store user data after successful registration
                  await _firebaseServices.storeUserData(user.uid, rollNo, nameController.text, departmentController.text, semesterController.text);

                  // Store student data in Firestore
                  await FirebaseFirestore.instance.collection('students').doc(rollNo).set({
                    'cardVAlue':cardValue.value.value,
                    'rollNo': rollNo,
                    'name': nameController.text,
                    'department': departmentController.text,
                    'semester': semesterController.text,
                  });

                  // Navigate to next screen or perform any other action
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
