

// import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
// import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
// import 'package:achno/App%20Screens/SplashScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//    // Ensure Firebase is initialized before running the app
//   try {
//     await Firebase.initializeApp();
//   } catch (e) {
//     print("Firebase initialization failed::::::::: $e");
//   } // Initialize Firebase
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(  // Use GetMaterialApp to enable GetX features
//       title: 'App Name',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: const SplashScreen(),  // Set SplashScreen as the first screen
//       routes: {
//         '/login': (context) =>  LoginScreen(),
//         '/signup': (context) =>  SignupScreen(),
//       },
//     );
//   }
// }


import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
import 'package:achno/App%20Screens/Home%20Screens/Home%20Screen.dart';
import 'package:achno/App%20Screens/Home%20Screens/Messages.dart';
import 'package:achno/App%20Screens/Home%20Screens/Notifications.dart';
import 'package:achno/App%20Screens/SplashScreen.dart';
import 'package:achno/Utils/Localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure Firebase is initialized before running the app
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization failed::::::::: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Name',
      theme: ThemeData(primarySwatch: Colors.green),
      supportedLocales: AppLocalizations.supportedLocales, // Define supported languages
      locale: Get.deviceLocale, // Use the device's locale
      localizationsDelegates: [
        AppLocalizations.delegate, // AppLocalizations delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const SplashScreen(), // Set SplashScreen as the first screen
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(), 
        '/messages': (context) => Messages(),
        '/notifications': (context) => NotificationsScreen(), 
      },
    );
  }
}
