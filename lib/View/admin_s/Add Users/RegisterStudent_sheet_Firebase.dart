import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/View/Widgets/EassPassTextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../Model/GoogleSheet/GoogleSheetClass.dart';
import '../../../Model/Real-Time Card Value, Date & Time/card_value.dart';
import '../../../constant.dart';
import '../../Widgets/Eass_Button.dart';
import '../../sign_in.dart';

class RegisterStudent extends StatefulWidget {
  const RegisterStudent({super.key});

  @override
  State<RegisterStudent> createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {


final  CardValue cardValue = Get.put(CardValue());

/////////////////////////
  /// Date & Time
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: selectedTime.hour + 1, minute: 0), // Next hour
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        print(selectedTime);
      });
    }
  }
  final _formfield = GlobalKey<FormState>();

  //////
  TextEditingController rollNoController = TextEditingController();
  /////
  String? selectedPaper;
  List<String> papers = []; // List to hold paper values
  ////
  String? selecteRoom;
  List<String> room = []; // List to hold paper values
  ////
  String? selectInvagilator;
  List<String> invagilator = []; // List to hold paper values
  //

  void _searchStudent() async {
    String rollNo = rollNoController.text;
    if (rollNo.isEmpty) {
      return;
    }
    Map<String, dynamic>? student = await StudentRecordsSheet.getById(rollNo);
    if (student != null) {
      // Populate paper values from student data
      setState(() {
        papers = [
          student['Paper1'],
          student['Paper2'],
          student['Paper3'],
          student['Paper4'],
        ];
        room =[
          ///////
          student['Room No1'],
          student['Room No2'],
          student['Room No3'],
          student['Room No4'],
          student['Room No5'],
        ];
        invagilator =[
          student['Invagilator1'],
          student['Invagilator2'],
          student['Invagilator3'],
        ];
      });
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
              Text("Student Registation",style: TextStyle(fontSize: responsiveTextSize(22),fontWeight: FontWeight.bold,color: Colors.white),),
              GestureDetector(
                child: Icon(Icons.logout,
                  size: 25,
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

            ],
          )

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Lottie.asset('assets/images/Animation - 1702660127762.json',),
            ),
            SizedBox(height: h*0.022,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Form(
                  child:Column(
                    children: [

                      Center(
                        child: GetX<CardValue>(
                            init: cardValue,
                            builder: (controller){
                              return Text("Card UID:  "+controller.value.value,
                                style: TextStyle(fontFamily: "BoldFonts",fontWeight: FontWeight.bold,fontSize: responsiveTextSize(20)),);

                            }),
                      ),
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

                      SizedBox(height: h*0.002,),
                      DropdownButtonFormField<String>(
                        value: selectedPaper,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPaper = newValue;
                          });
                        },
                        items: papers.map<DropdownMenuItem<String>>((String paper) {
                          return DropdownMenuItem<String>(
                            value: paper,
                            child: Text(paper),
                          );
                        }).toList(),
                        icon: const Icon(Icons.arrow_drop_down_circle,
                          color: kTextColor,
                        ),
                        decoration: InputDecoration(
                            labelText: 'Select Paper',
                            prefixIcon: Icon(Icons.payments,color: kTextColor,),
                            border: UnderlineInputBorder()

                        ),
                      ),
                      SizedBox(height: h*0.002,),
                      DropdownButtonFormField<String>(
                        value: selecteRoom,
                        onChanged: (String? newValue) {
                          setState(() {
                            selecteRoom = newValue;
                          });
                        },
                        items: room.map<DropdownMenuItem<String>>((String room) {
                          return DropdownMenuItem<String>(
                            value: room,
                            child: Text(room),
                          );
                        }).toList(),
                        icon: const Icon(Icons.arrow_drop_down_circle,
                          color: kTextColor,
                        ),
                        decoration: InputDecoration(
                            labelText: 'Select Class',
                            prefixIcon: Icon(Icons.payments,color: kTextColor,),
                            border: UnderlineInputBorder()

                        ),
                      ),
                      SizedBox(height: h*0.002,),
                      DropdownButtonFormField<String>(
                        value: selectInvagilator,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectInvagilator = newValue;
                          });
                        },
                        items: invagilator.map<DropdownMenuItem<String>>((String invagilator) {
                          return DropdownMenuItem<String>(
                            value: invagilator,
                            child: Text(invagilator),
                          );
                        }).toList(),
                        icon: const Icon(Icons.arrow_drop_down_circle,
                          color: kTextColor,
                        ),
                        decoration: InputDecoration(
                            labelText: 'Select Invigilator',
                            prefixIcon: Icon(Icons.payments,color: kTextColor,),
                            border: UnderlineInputBorder()
                        ),

                      ),
                      SizedBox(height: h*0.009,),

                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, color: kTextColor),
                              SizedBox(width: w*0.05),
                              Text('Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                                style: TextStyle(fontSize: responsiveTextSize(18),fontFamily: "BoldFonts"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.022),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, color: kTextColor),
                              SizedBox(width: w*0.025),
                              Text(
                                'Selected Time: ${selectedTime.format(context)}',
                                style: TextStyle(fontSize: responsiveTextSize(18),fontFamily: "BoldFonts"),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            SizedBox(height: h*0.022,),
            EassButton(label: "Register", onPressed: (){

            }
            ),
            SizedBox(height: h*0.022,),





          ],
        ),
      ),
    );
  }


  // RFID Card Real Time values

}
