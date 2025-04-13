// import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
// import 'package:achno/Common%20Components/CommonButton.dart';
// import 'package:achno/Common%20Components/CustomTextField.dart';
// import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';
// import 'package:achno/Utils/Localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

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
//         title: Text(AppLocalizations.of(context)!.signUp), // Use localized string
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
//                 'assets/icons/Slogo.png', // Ensure you have the logo image at this path
//                 height: 60,
//                 width: 60,
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               AppLocalizations.of(context)!.signUp, // Use localized string
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Please enter your details to proceed',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             SizedBox(height: 40),
//             // Number TextField
//             CommonTextField(
//               controller: _numberController,
//            hintText   : 'Enter Number', // Change based on language
//             ),
//             SizedBox(height: 15),
//             // Language Dropdown
//             DropdownButton<String>(
//               value: 'Arabic', // This can be dynamically set based on the current language
//               items: <String>['English', 'Arabic', 'French']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 // Change language on selection
//                 if (newValue == 'English') {
//                   Get.updateLocale(Locale('en', ''));
//                 } else if (newValue == 'Arabic') {
//                   Get.updateLocale(Locale('ar', ''));
//                 } else if (newValue == 'French') {
//                   Get.updateLocale(Locale('fr', ''));
//                 }
//               },
//             ),
//             SizedBox(height: 15),
//             // Password TextField
//             CommonTextField(
           
//               controller: _passwordController,
//             hintText  : AppLocalizations.of(context)!.signUp, // Use localized string
//               isPassword: true,
//             ),
//             SizedBox(height: 15),
//             // Confirm Password TextField
//             CommonTextField(
//               controller: _confirmPasswordController,
//             hintText  : AppLocalizations.of(context)!.signUp, // Use localized string
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
//                   final user = await authController.signUp(number, password,confirmPassword);

//                   if (user != null) {
//                     Get.offAllNamed('/home'); // Navigate to home screen
//                   } else {
//                     // Show error message
//                     Get.snackbar(AppLocalizations.of(context)!.signUp, 'Something went wrong');
//                   }
//                 } else {
//                   // Passwords do not match
//                   Get.snackbar(AppLocalizations.of(context)!.signUp, 'Passwords do not match');
//                 }
//               },
//               text: AppLocalizations.of(context)!.signUp, // Use localized string
//             ),
//             SizedBox(height: 20),
//             // Login Redirect Button
//             Align(
//               alignment: Alignment.center,
//               child: TextButton(
//                 onPressed: () {
//                   Get.to(() => LoginScreen());
//                 },
//                 child: Text(AppLocalizations.of(context)!.logIn), // Use localized string
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:achno/App%20Screens/SplashScreen.dart';
import 'package:achno/Common%20Components/CommonButton.dart';
import 'package:achno/Common%20Components/CustomTextField.dart';
import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';
import 'package:achno/Utils/locale_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final RxString selectedLanguage = ''.obs;
final box = GetStorage();
  @override
  Widget build(BuildContext context) {
     selectedLanguage.value = box.read('lang') == 'fr'
      ? 'French'
      : box.read('lang') == 'ar'
          ? 'Arabic'
          : 'English';
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/icons/Slogo.png', // Make sure this matches the logo
                height: 90,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Create Account!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Please enter your details to proceed',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            CustomTextField(
              controller: numberController,
              hintText: 'Enter Number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),

          Obx(() => Container(
  padding: const EdgeInsets.symmetric(horizontal: 15),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade400),
    borderRadius: BorderRadius.circular(8),
  ),
  child: DropdownButton<String>(
    value: selectedLanguage.value,
    isExpanded: true,
    underline: const SizedBox(),
    icon: const Icon(Icons.keyboard_arrow_down),
    items: ['English', 'Arabic', 'French']
        .map((lang) => DropdownMenuItem<String>(
              value: lang,
              child: Text(lang),
            ))
        .toList(),
    onChanged: (String? lang) {
      selectedLanguage.value = lang!;

      if (lang == 'English') {
        box.write('lang', 'en');
      } else if (lang == 'Arabic') {
        box.write('lang', 'ar');
      } else if (lang == 'French') {
        box.write('lang', 'fr');
      }

      // Force app to re-render by restarting root
      //Get.offAll(() => const SplashScreen());
    },
  ),
)),

            const SizedBox(height: 15),

            Obx(() => CustomTextField(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: authController.isPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      authController.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: authController.togglePasswordVisibility,
                  ),
                )),
            const SizedBox(height: 15),

            Obx(() => CustomTextField(
                  controller: confirmPasswordController,
                  hintText: 'Enter confirm password',
                  obscureText: authController.isConfirmPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      authController.isConfirmPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: authController.toggleConfirmPasswordVisibility,
                  ),
                )),
            const SizedBox(height: 30),
            /////////// with phone
//             CustomButton(
//   text: 'Register',
//   onPressed: () async {
//     final phone = numberController.text.trim();
//     final password = passwordController.text.trim();
//     final confirmPassword = confirmPasswordController.text.trim();

//     if (password != confirmPassword) {
//       Get.snackbar('Error', 'Passwords do not match');
//       return;
//     }

//     final user = await authController.signUp(phone, password);
//     if (user == null) {
//       Get.snackbar('Error', 'Signup failed');
//     }
//   },
// ),



            CustomButton(
              text: 'Register',
              onPressed: () async {
                final number = numberController.text.trim();
                final password = passwordController.text.trim();
                final confirmPassword = confirmPasswordController.text.trim();

                if (password != confirmPassword) {
                  Get.snackbar('Error', 'Passwords do not match');
                  return;
                }

                final user = await authController.signUp(number, password, confirmPassword);
                if (user == null) {
                  Get.snackbar('Error', 'Something went wrong');
                }
              },
            ),
          
          
            const SizedBox(height: 15),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'After register you agree to our ',
                  children: [
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
