import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/View/Add_students.dart';
import 'package:eass/View/GoogleSheet/SheetAddValues.dart';
import 'package:eass/View/Home/Home.dart';
import 'package:eass/View/admin_s/Add%20Users/add_users.dart';
import 'package:eass/View/admin_s/Add%20Users/matchRealTimeData.dart';
import 'package:eass/View/admin_s/Admin_Home/admin_home.dart';
import 'package:eass/View/onboarding_screens/onboarding.dart';
import 'package:eass/View/onboarding_screens/screen1.dart';
import 'package:eass/View/sign_in.dart';
import 'package:eass/View/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Model/GoogleSheet/GoogleSheetClass.dart';
import 'Model/Real-Time Card Value, Date & Time/DateValue.dart';
import 'Model/Real-Time Card Value, Date & Time/TimeValue.dart';
import 'Model/Real-Time Card Value, Date & Time/card_value.dart';
import 'View/GoogleSheetView.dart';
import 'View/admin_s/Add Users/RegisterStudent_sheet_Firebase.dart';
import 'firebase_options.dart';


bool? seenOnboard;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  //await FirebaseAppCheck.instance.activate();
  await StudentRecordsSheet.init();
  SharedPreferences preferences  = await SharedPreferences.getInstance();
  seenOnboard = preferences.getBool('seenOnboard')?? false;
  runApp( Eass());
  while (true) {
    await fetchCardUIDAndStatus();
    await Future.delayed(Duration(seconds: 5)); // Adjust the delay as needed
  }

}

DatabaseReference ref = FirebaseDatabase. instance. ref("alam");


final CardValue StoredUIDValue = Get.put(CardValue()); // Hardware CardUID
final DateValue dateValue = Get.put(DateValue());
final TimeValue timeValue = Get.put(TimeValue());

String? cardUID; // Variable to store cardUID
String? date; // Variable to store date
String? time;
String? status; // Variable to store status

String storeUID = ''; // Initialize storeUID

// Function to fetch cardUID, date, and status for the current user
Future<void> fetchCardUIDAndStatus() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Query Firestore to get all documents from the users collection
    QuerySnapshot querySnapshot = await firestore.collection('users').get();

    // Extract cardUID, date, and time values from all documents
    List<Map<String, dynamic>> cardsData = querySnapshot.docs.map((doc) {
      return {
        'cardUID': doc.get('cardUID'),
        'date': doc.get('date'), // Assuming date field exists in Firestore documents
        'time': doc.get('time'),
      };
    }).toList();

    // Update storeUID with the value from CardValue
    storeUID = StoredUIDValue.value.value;

    print("StoredUID: $storeUID");

    // Check if storeUID matches any of the cardUID values
    for (int i = 0; i < cardsData.length; i++) {
      Map<String, dynamic> cardData = cardsData[i];
      if (cardData['cardUID'] == storeUID) {
        // Get the document reference of the matching cardUID
        DocumentReference docRef = querySnapshot.docs[i].reference;

        // Get the date and time associated with the card UID
        date = cardData['date'];
        time = cardData['time'];
        print("Firestore Date: $date");
        print("Firestore time: $time");

        // Compare date and time with current date and time
        String currentDate = dateValue.value.value;
        String currentTime = timeValue.value.value;

        print("this is Real $currentTime");
        print("this is Real $currentDate");

        if (date == currentDate && time == currentTime) {

          status = 'Present';

          await docRef.update({'status': 'Present'});

        //  await ref.set({'PresentStatus': 1});
          await ref.set({'status': 1});


        } else {

          await docRef.update({'status': 'Absent'});
          status = 'Absent';
          //await ref.set({'AbsentStatus': 1});
          await ref.set({'status': 0});


        }
        return; // Exit the function if match is found
      }
    }
    // Update the status to "absent" if no match is found
    status = "Not Availabe user";
  } catch (error) {
    print("Error fetching cardUID and status: $error");
    // Handle errors here
  }
}

class Eass extends StatefulWidget {
   Eass({super.key});

  @override
  State<Eass> createState() => _EassState();
}

class _EassState extends State<Eass> {
  // This widget is the root of your application.
  void initState() {
    super.initState();
    StoredUIDValue.fetchCardValue(); // Fetch card value from CardValue controller
    fetchCardUIDAndStatus(); // Fetch cardUID, date, and status when the screen initializes
    timeValue.fetchCardValue();
    dateValue.fetchCardValue();
  }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EASS Exam Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: YourScreen(),
      home: seenOnboard == true? SignIn(): Onboarding(),
    );
  }
}
