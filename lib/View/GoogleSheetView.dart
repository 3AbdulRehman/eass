import 'package:eass/View/Widgets/Eass_Button.dart';
import 'package:flutter/material.dart';
import '../Model/GoogleSheet/GoogleSheetClass.dart';
import '../constant.dart';

class GoogleSheetUI extends StatefulWidget {
  const GoogleSheetUI({Key? key}) : super(key: key);

  @override
  State<GoogleSheetUI> createState() => _GoogleSheetUIState();
}

class _GoogleSheetUIState extends State<GoogleSheetUI> {
  TextEditingController rollNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  String? selectedPaper;
  List<String> papers = []; // List to hold paper values

  String? selecteRoom;
  List<String> room = []; // List to hold paper values

  String? selectInvagilator;
  List<String> invagilator = []; // List to hold paper values



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
        title: Text('Register Students',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: rollNoController,
                    decoration: InputDecoration(labelText: 'Enter the Roll No'),
                  ),
                ),
                GestureDetector(
                    child: Icon(Icons.flip_camera_android_outlined,size: 25,color: kTextColor,),
                  onTap:_searchStudent
                ),

              ],
            ),
            SizedBox(height: h*0.002,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
              readOnly: true,
            ),
            SizedBox(height: h*0.002,),
            TextField(
              controller: departmentController,
              decoration: InputDecoration(labelText: 'Department'),
              readOnly: true,
            ),
            SizedBox(height: h*0.002,),
            TextField(
              controller: semesterController,
              decoration: InputDecoration(labelText: 'Semester'),
              readOnly: true,
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

            SizedBox(height: h*0.022,),
            EassButton(label: "Register", onPressed: (){}
            )
          ],
        ),
      ),
    );
  }
}
