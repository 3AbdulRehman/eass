import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constant.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;


class UserDatabase extends StatefulWidget {
  const UserDatabase({super.key});

  @override
  State<UserDatabase> createState() => _UserDatabaseState();
}

class _UserDatabaseState extends State<UserDatabase> {
  late List<Map<String, dynamic>> userData = []; // Initialize as an empty list
  bool isLoaded = false;

  // Function to fetch user data from Firestore
  _fetchUserData() async {
    try {
      var collection = FirebaseFirestore.instance.collection('users');
      var querySnapshot = await collection.get();

      setState(() {
        userData = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['userID'] = doc.id; // Add the user ID to the data map
          return data;
        }).toList();
        isLoaded = true;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserData();

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/logo.png",
              height: h*0.25,
              width: w*0.25,
            ),
            SizedBox(width: w*0.001,),
            Text("Database Users",style: TextStyle(fontSize: responsiveTextSize(20),fontWeight: FontWeight.bold),)

            //Text("Edit And Update Users")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: isLoaded
                  ? DataTable(
                columns: [
                  DataColumn(label: Text('Name',style: TextStyle(fontFamily: "BoldFonts",fontSize: responsiveTextSize(14)),)),
                  DataColumn(label: Text('Roll Number',style: TextStyle(fontFamily: "BoldFonts",fontSize: responsiveTextSize(14),),)),
                  DataColumn(label: Text('Action',style: TextStyle(fontFamily: "BoldFonts",),)),

                  // Add more DataColumn widgets for additional fields
                ],
                rows: userData.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Text(user['name'] ?? 'N/A',style: TextStyle(fontSize: responsiveTextSize(15),))),
                      DataCell(Text(user['rollNumber'] ?? 'N/A',style: TextStyle(fontSize: responsiveTextSize(15),),)),

                      DataCell(Row(
                        children: [
                          SizedBox(width: 8),
                          GestureDetector(
                            child: Icon(Icons.print,size: 20,),
                            onTap: (){
                           UserPrint(user);
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


          ],
        ),
      ),


    );
  }
  void UserPrint(Map<String, dynamic> user) async {
    final pdf = pw.Document();

    // Load the first image from assets
    // Load the image from assets
    final ByteData data = await rootBundle.load('assets/images/smiu.png');

    // Explicitly convert List<int> to Uint8List
    final Uint8List bytes = Uint8List.fromList(data.buffer.asUint8List());

    // Load the second image from assets
    final ByteData data2 = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes2 = Uint8List.fromList(data2.buffer.asUint8List());




    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,

            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Image(pw.MemoryImage(Uint8List.fromList(bytes)), width: 70, height: 85),
                    pw.SizedBox(width: 10),
                    pw.Text('Sindh Madressatul Islam University,Karachi', style: pw.TextStyle(fontSize: 18,fontWeight:pw.FontWeight.bold)),
                    pw.Image(pw.MemoryImage(Uint8List.fromList(bytes2)), width: 95, height: 95),
                  ]
              ),
              pw.SizedBox(height: 60),
              pw.Center(child:pw.Text('User Infromation Record', style: pw.TextStyle(fontSize: 25,fontWeight:pw.FontWeight.bold)),),
              pw.SizedBox(height: 50),
              pw.Text('Card UID : ${user['cardUID'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18),
              pw.Text('rollNumber : ${user['rollNumber'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18),
              pw.Text('name : ${user['name'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18,),
              pw.Text('Paper : ${user['paperName'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18,),
              pw.Text('Class Room: ${user['roomNumber'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18,),
              pw.Text('Department : ${user['department'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18,),
              pw.Text('Instructor : ${user['instructor'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18,),
              pw.Text('Date : ${user['date'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18,),
              pw.Text('Time : ${user['time'] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 18,),
              pw.Text('Status : ${user[''] ?? 'N/A'}', style: pw.TextStyle(fontSize: 20)),




              pw.SizedBox(height: 285,),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text('Supervisor : ',style: pw.TextStyle(fontSize: 20,fontWeight:pw.FontWeight.bold)),
                    pw.Text('Sir Ameen Khowaja ',style: pw.TextStyle(fontSize: 20)),
                  ]
              ),
              pw.SizedBox(height: 18,),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text('Design by : ',style: pw.TextStyle(fontSize: 15,fontWeight:pw.FontWeight.bold)),
                    pw.Text('Abdul Rehman(070), Hamza Khan(075), Khizar Sajid(077) ',style: pw.TextStyle(fontSize: 15)),
                  ]
              ),


            ],
          );
        },
      ),
    );

    await _saveAndLaunchPdf(pdf,user);
  }
  Future<void> _saveAndLaunchPdf(pw.Document pdf, Map<String, dynamic> user) async {
    final bytes = await pdf.save();
    final directory = await getExternalStorageDirectory();

    // Extract the user's name from the map
    final userName = user['name'] ?? 'Unknown';

    // Use the user's name in the filename
    final filename = '$userName Information Record.pdf';

    final file = File('${directory!.path}/$filename');
    await file.writeAsBytes(bytes);

    OpenFile.open(file.path);
    print(OpenFile);
  }


}
