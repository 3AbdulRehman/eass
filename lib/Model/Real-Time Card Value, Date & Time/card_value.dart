


import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class CardValue extends GetxController{
  final _database = FirebaseDatabase.instance.ref('rfid');
  var value = "Loading".obs;

  void fetchCardValue(){
    _database.child('storedUID').onValue.listen((event) {
      final data = event.snapshot.value;
      if(data!= null){
        print(data);
        value.value = data.toString();
      }else{
        value.value = 'Card UID Not Found';
      }
    });
  }

}



