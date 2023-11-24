import 'package:eass/View/Home.dart';
import 'package:eass/View/admin_s/Admin_Home/admin_home.dart';
import 'package:eass/View/onboarding_screens/onboarding.dart';
import 'package:eass/View/onboarding_screens/screen1.dart';
import 'package:eass/View/sign_in.dart';
import 'package:eass/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'View/admin_s/theme.dart';
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Admin_Home(),//seenOnboard == true? SignIn(): Onboarding(),
    
    );
  }
}
