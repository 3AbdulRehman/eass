
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../constant.dart';
import '../../Widgets/Eass_Button.dart';
import '../../Widgets/Easstextfield.dart';

class EditUserTextFormField extends StatefulWidget {
  final Map<String, dynamic> user;

  EditUserTextFormField({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUserTextFormField> createState() => _EditUserTextFormFieldState();
}


class _EditUserTextFormFieldState extends State<EditUserTextFormField> {

  _EditUserTextFormFieldState(){
    selectedValue = Department[0];
  }


  //// Department DropDown
  List<String> Department = ["BSCS", "BSAI", "BBA", "BSCyS","BSES","BSE","BSMS"];
  //////////////////

  String selectedValue ="";

  /// Global Key
  final _formfield = GlobalKey<FormState>();
/////////////////////


  // Text Form Controller
  TextEditingController rollnumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController PaperNameController = TextEditingController();
  TextEditingController classNumberController = TextEditingController();
  TextEditingController InstructorController = TextEditingController();
  /////////

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

///////////////////////

  String CardValue = "";






  @override
void initState() {
    // TODO: implement initState
    super.initState();
    rollnumberController.text = widget.user['rollNumber']?.toString() ?? '';
    nameController.text = widget.user['name']?.toString() ?? '';
    PaperNameController.text= widget.user['paperName']?.toString()??'';
    classNumberController.text= widget.user['roomNumber']?.toString()??'';
    InstructorController.text= widget.user['instructorName']?.toString()??'';

    selectedValue = widget.user['department']?.toString()?? '';
    //
    CardValue = widget.user['cardUID']?.toString()??'';
    //
    String dateString = widget.user['date']?.toString() ?? '';
    selectedDate = dateString.isNotEmpty ? DateTime.parse(dateString) : DateTime.now();
    ///

  }
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
        title: Text("Edit & Update user",style: TextStyle(fontSize: responsiveTextSize(22),fontWeight: FontWeight.bold,color: Colors.black54),),
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

                    Center(child: Text("Card UID: "+CardValue,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "BoldFonts"),)),

                    SizedBox(height: h*0.023,),
                    EassTextField(labelText: "Roll Number", controller: rollnumberController, keyboardType: TextInputType.text,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Roll Number is Required";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: h*0.022,),
                    EassTextField(labelText: "Name", controller: nameController, keyboardType: TextInputType.text,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Name is Required";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: h*0.025,),

                    SizedBox(height: h*0.022,),
                    EassTextField(labelText: "Paper Name", controller: PaperNameController, keyboardType: TextInputType.text,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Paper Name is Required";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: h*0.022,),
                    EassTextField(labelText: "Room Number", controller: classNumberController, keyboardType: TextInputType.text,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Room Number is Required";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: h*0.022,),
                    EassTextField(labelText: "Instructor Name", controller: InstructorController, keyboardType: TextInputType.text,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Instructor Name is Required";
                        }else{
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: h*0.022,),

                    Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: DropdownButtonFormField(
                        value: selectedValue,
                        items: Department.map((e){
                          return DropdownMenuItem(child: Text(e),value: e,);
                        }
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue =value as String;
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down_circle,
                          color: kTextColor,
                        ),
                        //dropdownColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                            labelText: "Select Department",
                            prefixIcon: Icon(Icons.payments,color: kTextColor,),
                            border: UnderlineInputBorder()
                        ),
                        // hint: Text("Select Package",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),),
                      ),
                    ),
                    SizedBox(height: h * 0.022),
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
                    SizedBox(height: h * 0.025),




                  ],
                )
            ),
            EassButton(label: "Update", onPressed: () {
              if(_formfield.currentState!.validate()){
                _updateUserData(widget.user['userID']); // Assuming you have a unique identifier for each user
              }

            }),
            SizedBox(height: h * 0.020),



          ],
        ),
      ),




    );
  }


  void _updateUserData(String userId) async {
    try {
      if (userId != null) {
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'rollNumber': rollnumberController.text,
          'name': nameController.text,
          'paperName': PaperNameController.text,
          'roomNumber': classNumberController.text,
          'instructorName': InstructorController.text,
          'department': selectedValue,
          'date': DateFormat('yyyy-MM-dd').format(selectedDate),   ///selectedDate,
          'time': selectedTime.format(context),
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
}
