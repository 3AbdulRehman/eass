import 'package:eass/Model/Real%20Time%20Card%20Value/DateValue.dart';
import 'package:eass/Model/Real%20Time%20Card%20Value/TimeValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eass/Model/Real%20Time%20Card%20Value/card_value.dart';

class YourScreen extends StatefulWidget {
  @override
  State<YourScreen> createState() => _YourScreenState();
}

class _YourScreenState extends State<YourScreen> {

  final DateValue dateValue = Get.put(DateValue()); // Hardware Date
  final TimeValue timeValue = Get.put(TimeValue()); // Hardware Time
  ///////////////////////////////////////////////////////////



  final cardValueController = Get.put(CardValue()); // Hardware CardUID

  String? cardUID; // Variable to store cardUID
  String? status; // Variable to store status

  String storeUID = ''; // Initialize storeUID

  // Function to fetch cardUID and status for the current user
  Future<void> fetchCardUIDAndStatus() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query Firestore to get all documents from the users collection
      QuerySnapshot querySnapshot = await firestore.collection('users').get();

      // Extract cardUID values from all documents
      List cardUIDs = querySnapshot.docs.map((doc) => doc.get('cardUID')).toList();

      // Update storeUID with the value from CardValue
      storeUID = cardValueController.value.value;

      print("this StoredUID $storeUID");

      // Check if storeUID matches any of the cardUID values
      if (cardUIDs.contains(storeUID)) {
        // Get the index of the matching cardUID
        int index = cardUIDs.indexOf(storeUID);

        // Get the document reference of the matching cardUID
        DocumentReference docRef = querySnapshot.docs[index].reference;

        // Update the status to "present"
        await docRef.update({'status': 'present'});
        print("Match is $docRef");


        setState(() {
          status = "Present";
        });
      } else {
        // Update the status to "absent"
        setState(() {
          status = "Absent";
        });
      }
    } catch (error) {
      print("Error fetching cardUID and status: $error");
      // Handle errors here
    }
  }

  @override
  void initState() {
    super.initState();
    cardValueController.fetchCardValue(); // Fetch card value from CardValue controller
    fetchCardUIDAndStatus(); // Fetch cardUID and status when the screen initializes
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
            Text(
              'CardUID for Current User: ${cardUID ?? "Loading..."}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Status for Current User: ${status ?? "Loading..."}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
