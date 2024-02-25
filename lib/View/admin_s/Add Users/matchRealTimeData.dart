// Import necessary packages
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Model/Real-Time Card Value, Date & Time/DateValue.dart';
import '../../../Model/Real-Time Card Value, Date & Time/TimeValue.dart';
import '../../../Model/Real-Time Card Value, Date & Time/card_value.dart';

class YourScreen extends StatefulWidget {
  @override
  State<YourScreen> createState() => _YourScreenState();
}

class _YourScreenState extends State<YourScreen> {

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

            await ref.set({'PresentStatus': 1});

          } else {

            await docRef.update({'status': 'Absent'});
              status = 'Absent';
            await ref.set({'AbsentStatus': 1});



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
    ref.set({'PresentStatus': 0, 'AbsentStatus': 0});
  }

  @override
  void initState() {
    super.initState();
    StoredUIDValue.fetchCardValue(); // Fetch card value from CardValue controller
    fetchCardUIDAndStatus(); // Fetch cardUID, date, and status when the screen initializes
    timeValue.fetchCardValue();
    dateValue.fetchCardValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetX<CardValue>(
              init: StoredUIDValue,
              builder: (controller) {
                return Text(
                  "StoredUID: " + controller.value.value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Status for Current User: ${status ?? "Loading..."}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Date for Current User: ${date ?? "Not Available"}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Time for Current User: ${time ?? "Not Available"}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
