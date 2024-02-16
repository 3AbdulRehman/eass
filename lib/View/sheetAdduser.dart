

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Model/Real Time Card Value/card_value.dart';
import '../constant.dart';
import 'Widgets/EassPassTextfield.dart';
import 'Widgets/Easstextfield.dart';

class GoogleSheetAddUser extends StatefulWidget {
  const GoogleSheetAddUser({super.key});

  @override
  State<GoogleSheetAddUser> createState() => _GoogleSheetAddUserState();
}

class _GoogleSheetAddUserState extends State<GoogleSheetAddUser> {



  /// Global Key
  final _formfield = GlobalKey<FormState>();
/////////////////////


  final CardValue cardValue = Get.put(CardValue());
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

  String selectedValue ="";


  // Text Form Controller
  TextEditingController rollnumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController PaperNameController = TextEditingController();
  TextEditingController classNumberController = TextEditingController();
  TextEditingController InstructorController = TextEditingController();
  TextEditingController studentpassController = TextEditingController();
  /////////


  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    cardValue.fetchCardValue();
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Faculty Member:",style: TextStyle(fontSize: responsiveTextSize(22),fontWeight: FontWeight.bold,color: Colors.black54),),

            SizedBox(width: w*0.001,),
            Text("",style: TextStyle(fontSize: responsiveTextSize(20),fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(width: w*0.001,),
            /*GestureDetector(
              child: Icon(Icons.logout,
                size: 25,
                color: Colors.white,),
              onTap: () async {
                try{
                  await FirebaseAuth.instance.signOut();
                }catch (e){
                  print("Error During Logout :$e");

                }

              },

            ),
*/

            //Text("Edit And Update Users")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Center(
              child: Lottie.asset('assets/images/Animation - 1702660127762.json',),
            ),*/
            SizedBox(height: h*0.022,),
            Form(
                key: _formfield,
                child: Column(
                  children: [
                    Center(
                      child: GetX<CardValue>(
                          init: cardValue,
                          builder: (controller){
                            return Text("Card UID:  "+controller.value.value,
                              style: TextStyle(fontFamily: "BoldFonts",fontWeight: FontWeight.bold,fontSize: responsiveTextSize(20)),);

                          }),
                    ),
                    SizedBox(height: h*0.022,),
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
                    EassPassField(labelText: "Password", controller: studentpassController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Password is Required";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: h * 0.022),
                    /*Padding(
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
                    ),*/
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
            /*EassButton(label: "Registor", onPressed: () {
              if(_formfield.currentState!.validate()){
                AddUserToFirestore();
              }

            }),*/
            SizedBox(height: h * 0.020),



          ],
        ),
      ),

    );
  }

}
