import 'package:eass/View/Home/Home.dart';
import 'package:eass/View/admin_s/Add%20Users/add_users.dart';
import 'package:eass/View/admin_s/Add%20Users/matchRealTimeData.dart';
import 'package:eass/View/admin_s/Admin_Home/admin_home.dart';
import 'package:eass/View/onboarding_screens/onboarding.dart';
import 'package:eass/View/onboarding_screens/screen1.dart';
import 'package:eass/View/sheetAdduser.dart';
import 'package:eass/View/sign_in.dart';
import 'package:eass/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


bool? seenOnboard;


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences preferences  = await SharedPreferences.getInstance();
  seenOnboard = preferences.getBool('seenOnboard')?? false;
  runApp(const Eass());
}

class Eass extends StatelessWidget {
  const Eass({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EASS Exam Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: YourScreen(),
      home:seenOnboard == true? SignIn(): Onboarding(),
    );
  }
}
