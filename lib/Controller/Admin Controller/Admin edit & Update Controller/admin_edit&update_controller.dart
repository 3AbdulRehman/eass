import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminEditController extends GetxController {
  late RxList<Map<String, dynamic>> userData;
  late RxBool isLoaded;

  @override
  void onInit() {
    // Initialize your variables
    userData = <Map<String, dynamic>>[].obs;
    isLoaded = false.obs;

    // Fetch user data
    _fetchUserData();
    super.onInit();
  }

  // Function to fetch user data from Firestore
  void _fetchUserData() async {
    try {
      var collection = FirebaseFirestore.instance.collection('admins');
      collection.snapshots().listen((QuerySnapshot querySnapshot) {
        userData.assignAll(
          querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['userID'] = doc.id;
            return data;
          }).toList(),
        );
        isLoaded.value = true;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
  // Function to delete a user
  void deleteUser(String userId) async {
    bool confirm = await Get.defaultDialog(
      title: 'Confirm Deletion',
      content: Text('Are you sure you want to delete this user?'),
      cancel: ElevatedButton(
        onPressed: () => Get.back(result: false),
        child: Text('Cancel'),
      ),
      confirm: ElevatedButton(
        onPressed: () => Get.back(result: true),
        child: Text('Delete'),
      ),
    );

    if (confirm == true) {
      try {
        await FirebaseFirestore.instance.collection('admins').doc(userId).delete();
        print('User deleted successfully');
        User? firebaseUser = FirebaseAuth.instance.currentUser;

        if (firebaseUser != null) {
          await firebaseUser.delete();
          print('User deleted from Firebase Authentication successfully');
        } else {
          print('Error: Current user not found in Firebase Authentication');
        }
      } catch (e) {
        print("Error deleting user: $e");
      }
    }
  }

}
