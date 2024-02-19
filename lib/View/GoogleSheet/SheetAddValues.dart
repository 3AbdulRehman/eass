/*
import 'package:flutter/material.dart';

import '../../Model/GoogleSheet/GoogleSheetClass.dart';

class SheetAddValues extends StatefulWidget {
  const SheetAddValues({super.key});

  @override
  State<SheetAddValues> createState() => _SheetAddValuesState();
}

class _SheetAddValuesState extends State<SheetAddValues> {

  TextEditingController rollNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController SemesterController = TextEditingController();

  void _addUser() async {
    String rollNo = rollNoController.text;
    String name = nameController.text;
    String department = departmentController.text;
    String Semester = SemesterController.text;


    if (rollNo.isEmpty || name.isEmpty || department.isEmpty|| Semester.isEmpty) {
      // Handle if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill all fields!'),
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

    await StudentRecordsSheet.insert(rollNo, name, department,Semester);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('User added successfully!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              rollNoController.clear();
              nameController.clear();
              departmentController.clear();
              SemesterController.clear();

              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Sheet Add User information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: rollNoController,
              decoration: InputDecoration(labelText: 'Roll No'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: departmentController,
              decoration: InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: SemesterController,
              decoration: InputDecoration(labelText: 'Semester'),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _addUser,
                child: Text('Add User'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
