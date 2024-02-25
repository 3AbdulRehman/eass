import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/View/Home/Home_drawer.dart';
import 'package:eass/View/Home/homecard.dart';
import 'package:eass/View/Widgets/Eass_Button.dart';
import 'package:eass/View/admin_s/Add%20Users/matchRealTimeData.dart';
import 'package:eass/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Model/image_picker.dart';
import '../sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(); // Fetch data when the widget initializes
  }
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }
    return Scaffold(
      drawer: Home_Drawer(),
      body: Container(
        height: double.infinity,
        width:  double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                kTextColor.withOpacity(0.9),
                Colors.cyanAccent.withOpacity(0.9),
              ]
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: h*0.01,),
              Row(children: [
               Image.asset("assets/images/logo.png",
                 height: h*0.12,
                 width: w*0.24,
               ),
               Center(
                   child: Text("Exam Attendence Students System",style: TextStyle(fontSize: responsiveTextSize(18),fontWeight: FontWeight.bold,fontFamily: "BoldFonts",color: Colors.white),)
               ),
             ],
             ),

              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 22,top: 0),
                        child: GestureDetector(
                          child: Obx(
                            ()=>Container(
                              height: h*0.18,
                              width: w*0.32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                image:imagePickerController.imagePath.value.isNotEmpty
                                    ? DecorationImage(
                                  image: FileImage(File(imagePickerController.imagePath.value)),
                                  fit: BoxFit.cover,
                                )
                                    : DecorationImage(
                                  image: AssetImage('assets/icons/man.png'),
                                  fit: BoxFit.cover,
                                ),

                              ),
                            ),
                          ),
                          onTap: () async {
                            await imagePickerController.pickImage();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25,top: 0),
                        child: Column(
                          children: [
                            Text("Card UID Number",style: TextStyle(fontSize: responsiveTextSize(20),fontFamily: "BoldFonts",color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: h*0.01,),
                            Column(
                              children: [
                                Text("$cardUID",style: TextStyle(fontSize: responsiveTextSize(23),fontWeight: FontWeight.bold,color: Colors.black),)
                              ],
                            ),
                            SizedBox(height: h*0.015,),
                            Column(
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Colors.green), // Change the color here
                                    ),
                                    child: Text("Generate Report",style: TextStyle(fontSize: responsiveTextSize(15),fontWeight: FontWeight.bold,fontFamily: "BoldFonts",color: Colors.white),),
                                  onPressed: (){
                                  generatePdf(); // Call the function to generate the PDF

                                  },
                                )
                              ],
                            ),
                          ],

                        ),
                      ),


                    ],
                  ),

                ],
              ),
              SizedBox(height: h*0.04,),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.5,right: 7.5),
                  child: Row(
                    children: [
                      CardHome(child: Column(
                        children: [
                         Image.asset("assets/icons/roll.png",
                           height: h*0.08,
                           width: w*0.15,
                         ),
                          SizedBox(height: h*0.002,),
                          Column(
                            children: [
                              Center(child: Text("Roll Number",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$rollNumber",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          )
                        ],
                      )),
                      SizedBox(width: 5,),
                      CardHome(child: Column(
                        children: [
                          Image.asset("assets/icons/name.png",
                            height: h*0.08,
                            width: w*0.15,
                          ),
                          SizedBox(height: h*0.001,),
                          Column(
                            children: [
                              Center(child: Text("Name",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$name",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          )
                        ],
                      )),
                      SizedBox(width: 5,),
                      CardHome(child: Column(
                        children: [
                          Image.asset("assets/icons/paper.png",
                            height: h*0.09,
                            width: w*0.15,
                          ),
                          SizedBox(height: h*0.002,),
                          Column(
                            children: [
                              Center(child: Text("Paper",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$paper",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          ),
                        ],
                      )),
                    ],
                  ),

                ),
              ),
              SizedBox(height: h*0.03,),
              SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(left: 7.5,right: 7.5),
                  child: Row(
                    children: [
                      CardHome(child: Column(
                        children: [
                          Image.asset("assets/icons/room.png",
                            height: h*0.09,
                            width: w*0.15,
                          ),
                          SizedBox(height: h*0.002,),
                          Column(
                            children: [
                              Center(child: Text("Class Room",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$classRoom",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          ),

                        ],
                      )),
                      SizedBox(width: 5,),
                      CardHome(child: Column(
                        children: [
                          Image.asset("assets/icons/department.png",
                            height: h*0.09,
                            width: w*0.15,
                          ),
                          SizedBox(height: h*0.002,),
                          Column(
                            children: [
                              Center(child: Text("Department",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$department",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          ),

                        ],
                      )),
                      SizedBox(width: 5,),
                      CardHome(child: Column(
                        children: [
                          Image.asset("assets/icons/instructor.png",
                            height: h*0.09,
                            width: w*0.15,
                          ),
                          SizedBox(height: h*0.002,),
                          Column(
                            children: [
                              Center(child: Text("Instructor",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$instructor",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          ),
                        ],
                      )),
                    ],
                  ),

                ),
              ),
              SizedBox(height: h*0.03,),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 7.5,right: 7.5),
                  child: Row(
                    children: [
                      CardHome(child: Column(
                        children: [
                          Image.asset("assets/icons/date.png",
                            height: h*0.09,
                            width: w*0.15,
                          ),
                          SizedBox(height: h*0.002,),
                          Column(
                            children: [
                              Center(child: Text("Date",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$date",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          ),
                        ],
                      )),
                      SizedBox(width: 5,),
                      CardHome(child: Column(
                        children: [
                          Image.asset("assets/icons/time.png",
                            height: h*0.09,
                            width: w*0.15,
                          ),
                          SizedBox(height: h*0.002,),
                          Column(
                            children: [
                              Center(child: Text("Time",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$time",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          ),
                        ],
                      )),
                      SizedBox(width: 5,),
                      CardHome(child: Column(
                        children: [
                          Image.asset("assets/icons/present.png",
                            height: h*0.09,
                            width: w*0.15,
                          ),
                          SizedBox(height: h*0.002,),
                          Column(
                            children: [
                              Center(child: Text("Status",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(14),fontWeight: FontWeight.bold,fontFamily: "BoldFonts"),)),
                              SizedBox(height: h*0.002,),
                              Center(child: Text("$status",textAlign: TextAlign.center,style: TextStyle(fontSize: responsiveTextSize(12),fontWeight: FontWeight.bold,fontFamily: "RegularFonts"),)),

                            ],
                          ),
                        ],
                      )),
                    ],
                  ),

                ),
              ),
              SizedBox(height: h*0.04,),
              EassButton(label: "Lagout", onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.to(SignIn());
              }),

            ],
          ),
        ),
      ),
    );
  }
  String cardUID = "";
  String rollNumber = "";
  String name = "";
  String paper = "";
  String classRoom = "";
  String department = "";
  String instructor = "";
  String date = "";
  String time = "";
  String status = "";
  User? user = FirebaseAuth.instance.currentUser;

  // Function to fetch data from Firestore based on the current user's UID
  Future<void> fetchData() async {
    try {

      if (user != null) {
        String uid = user!.uid;

        // Replace 'your_collection_name' with the actual collection name in Firestore
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (snapshot.exists) {
          var data = snapshot.data();

          // Update state variables with fetched data
          setState(() {
            cardUID = data!['cardUID'] ?? "";
            rollNumber = data!['rollNumber'] ?? "";
            name = data['name'] ?? "";
            paper = data['paperName'] ?? "";
            classRoom = data['roomNumber'] ?? "";
            department = data['department'] ?? "";
            instructor = data['instructorName'] ?? "";
            date = data['date'] ?? "";
            time = data['time'] ?? "";
            status = data['status'] ?? "";
          });
        } else {
          // Handle the case when no data is found
          print('No data found in Firestore for UID: $uid');
        }
      } else {
        // Handle the case when the user is not authenticated
        print('User not authenticated');
      }
    } catch (e) {
      // Handle any potential errors
      print('Error fetching data from Firestore: $e');
    }
  }


  ///
///
///
  Future<void> generatePdf() async {
    final pdf = pw.Document();
    // Load the first image from assets
    // Load the image from assets
    final ByteData data = await rootBundle.load('assets/images/smiu.png');

    // Explicitly convert List<int> to Uint8List
    final Uint8List bytes = Uint8List.fromList(data.buffer.asUint8List());

    // Load the second image from assets
    final ByteData data2 = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes2 = Uint8List.fromList(data2.buffer.asUint8List());


    // Add a page to the PDF
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        // Add your data to the PDF
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
            pw.SizedBox(height: 50),
            pw.Center(child:pw.Text('Student Infromation Record', style: pw.TextStyle(fontSize: 25,fontWeight:pw.FontWeight.bold)),),
            pw.SizedBox(height: 40),
            pw.Text('Card UID      :  $cardUID',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Roll Number :  $rollNumber',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Name           :   $name',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Paper           :   $paper',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Class Room :   $classRoom',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Department  :   $department',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Instructor      :  $instructor',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Date             :  $date',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Time             :   $time',style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 15),
            pw.Text('Status           : $status',style: pw.TextStyle(fontSize: 20)),

            pw.SizedBox(height: 85,),
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
    ));
    await _saveAndLaunchPdf(pdf);

  }
  Future<void> _saveAndLaunchPdf(pw.Document pdf) async {
    final bytes = await pdf.save();
    final directory = await getExternalStorageDirectory();
    // Use the user's name in the filename
    final filename = '$rollNumber Record File.pdf';

    final file = File('${directory!.path}/$filename');

    await file.writeAsBytes(bytes);

    OpenFile.open(file.path);
    print(OpenFile);
  }

}
