
import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
import 'package:achno/App%20Screens/Home%20Screens/Messages.dart';
import 'package:achno/App%20Screens/Home%20Screens/Notifications.dart';
import 'package:achno/App%20Screens/SplashScreen.dart';
import 'package:achno/Home.dart';
import 'package:achno/Utils/Localization.dart';
import 'package:achno/Utils/locale_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure Firebase is initialized before running the app
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization failed::::::::: $e");
  }
    await GetStorage.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  
   MyApp({Key? key}) : super(key: key);
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
      String savedLocale = box.read('lang') ?? 'en';
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Name',
      theme: ThemeData(primarySwatch: Colors.green),
       locale: Locale(savedLocale),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate, // <- your custom delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // supportedLocales: AppLocalizations.supportedLocales, // Define supported languages
      // locale: Get.deviceLocale, // Use the device's locale
      // localizationsDelegates: [
      //   AppLocalizations.delegate, // AppLocalizations delegate
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      home: const SplashScreen(), // Set SplashScreen as the first screen
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => Home(), 
        '/messages': (context) => Messages(),
        '/notifications': (context) => NotificationsScreen(), 
      },
    );
  }
}
