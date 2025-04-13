
import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
import 'package:achno/Home.dart';
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
        Get.offAll(() =>  Home());  // Navigate to LoginScreen if logged in
      } else {
        Get.offAll(() =>  SignupScreen());  // Navigate to SignupScreen if not logged in
      }
    });

    return Scaffold(
   
      body: Container(
        height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(129, 203, 194, 1), 
        Color.fromRGBO(32, 160, 144, 1),  
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment .center,
            
            children: [
              SizedBox(height: 300,),
              Image.asset('assets/images/logo.png'),
              Text("Achno", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),)
            ],
          ),
        ),
      ),
    );
  }
}
