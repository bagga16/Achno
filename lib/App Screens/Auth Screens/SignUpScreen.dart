import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
import 'package:achno/Common%20Components/CommonButton.dart';
import 'package:achno/Common%20Components/CustomTextField.dart';
import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';
import 'package:achno/Utils/Localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signUp), // Use localized string
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/Slogo.png', // Ensure you have the logo image at this path
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.signUp, // Use localized string
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Please enter your details to proceed',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 40),
            // Number TextField
            CommonTextField(
              controller: _numberController,
           hintText   : 'Enter Number', // Change based on language
            ),
            SizedBox(height: 15),
            // Language Dropdown
            DropdownButton<String>(
              value: 'Arabic', // This can be dynamically set based on the current language
              items: <String>['English', 'Arabic', 'French']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Change language on selection
                if (newValue == 'English') {
                  Get.updateLocale(Locale('en', ''));
                } else if (newValue == 'Arabic') {
                  Get.updateLocale(Locale('ar', ''));
                } else if (newValue == 'French') {
                  Get.updateLocale(Locale('fr', ''));
                }
              },
            ),
            SizedBox(height: 15),
            // Password TextField
            CommonTextField(
           
              controller: _passwordController,
            hintText  : AppLocalizations.of(context)!.signUp, // Use localized string
              isPassword: true,
            ),
            SizedBox(height: 15),
            // Confirm Password TextField
            CommonTextField(
              controller: _confirmPasswordController,
            hintText  : AppLocalizations.of(context)!.signUp, // Use localized string
              isPassword: true,
            ),
            SizedBox(height: 30),
            // Register Button
            CommonButton(
              onPressed: () async {
                final number = _numberController.text;
                final password = _passwordController.text;
                final confirmPassword = _confirmPasswordController.text;

                if (password == confirmPassword) {
                  final user = await authController.signUp(number, password);

                  if (user != null) {
                    Get.offAllNamed('/home'); // Navigate to home screen
                  } else {
                    // Show error message
                    Get.snackbar(AppLocalizations.of(context)!.signUp, 'Something went wrong');
                  }
                } else {
                  // Passwords do not match
                  Get.snackbar(AppLocalizations.of(context)!.signUp, 'Passwords do not match');
                }
              },
              text: AppLocalizations.of(context)!.signUp, // Use localized string
            ),
            SizedBox(height: 20),
            // Login Redirect Button
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: Text(AppLocalizations.of(context)!.logIn), // Use localized string
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
// import 'package:achno/Common%20Components/CommonButton.dart';
// import 'package:achno/Common%20Components/CustomTextField.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Controllers/Auth Controller/AuthController.dart';
// class SignupScreen extends StatelessWidget {
//   SignupScreen({Key? key}) : super(key: key);

//   final TextEditingController _numberController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.put(AuthController());

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Account'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: ListView(
//           children: [
//             SizedBox(height: 30),
//             Align(
//               alignment: Alignment.center,
//               child: Image.asset(
//                 'assets/images/world_logo.png', // Ensure you have the logo image at this path
//                 height: 60,
//                 width: 60,
//               ),
//             ),
//             SizedBox(height: 20),
//             const Text(
//               'Create Account!',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Please enter your details to proceed',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             SizedBox(height: 40),
//             // Number TextField
//             CommonTextField(
              
//               controller: _numberController,
//               hintText: 'Enter Number',
//             ),
//             SizedBox(height: 15),
//             // Language Dropdown
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey),
//               ),
//               child: DropdownButton<String>(
//                 value: 'Arabic',
//                 isExpanded: true,
//                 icon: Icon(Icons.arrow_drop_down),
//                 style: TextStyle(color: Colors.black),
//                 items: <String>['English', 'Arabic', 'French']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   // Handle language change logic here
//                 },
//               ),
//             ),
//             SizedBox(height: 15),
//             // Password TextField
//             CommonTextField(
//               controller: _passwordController,
//               hintText: 'Enter Password',
//               isPassword: true,
//             ),
//             SizedBox(height: 15),
//             // Confirm Password TextField
//             CommonTextField(
//               controller: _confirmPasswordController,
//               hintText: 'Enter Confirm Password',
//               isPassword: true,
//             ),
//             SizedBox(height: 30),
//             // Register Button
//             CommonButton(
//               onPressed: () async {
//                 final number = _numberController.text;
//                 final password = _passwordController.text;
//                 final confirmPassword = _confirmPasswordController.text;

//                 if (password == confirmPassword) {
//                   final user = await authController.signUp(number, password);

//                   if (user != null) {
//                     Get.offAllNamed('/home'); // Navigate to home screen
//                   } else {
//                     // Show error message
//                     Get.snackbar('Error', 'Something went wrong');
//                   }
//                 } else {
//                   // Passwords do not match
//                   Get.snackbar('Error', 'Passwords do not match');
//                 }
//               },
//               text: 'Register',
//             ),
//             SizedBox(height: 20),
//             // Login Redirect Button
//             Align(
//               alignment: Alignment.center,
//               child: TextButton(
//                 onPressed: () {
//                   Get.to(() => LoginScreen()); // Navigate to LoginScreen
//                 },
//                 child: const Text(
//                   'Already have an account? Log In',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
