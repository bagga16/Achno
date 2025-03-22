import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/Auth Controller/AuthController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    final AuthController authController = Get.put(AuthController());

    // Delay to simulate splash screen and then navigate
    Future.delayed(const Duration(seconds: 2), () {
      if (authController.isLoggedIn()) {
        Get.offAll(() =>  LoginScreen());  // Navigate to LoginScreen if logged in
      } else {
        Get.offAll(() =>  SignupScreen());  // Navigate to SignupScreen if not logged in
      }
    });

    return Scaffold(
      backgroundColor: Colors.green,  // Customize splash screen color
      body: Center(
        child: Image.asset('assets/images/splash_logo.png'),  // Add your splash logo
      ),
    );
  }
}
