

import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
import 'package:achno/App%20Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // Ensure Firebase is initialized before running the app
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization failed::::::::: $e");
  } // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Use GetMaterialApp to enable GetX features
      title: 'App Name',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen(),  // Set SplashScreen as the first screen
      routes: {
        '/login': (context) =>  LoginScreen(),
        '/signup': (context) =>  SignupScreen(),
      },
    );
  }
}
