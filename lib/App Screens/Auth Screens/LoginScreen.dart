// import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Controllers/Auth Controller/AuthController.dart';

// class LoginScreen extends StatelessWidget {
//    LoginScreen({Key? key}) : super(key: key);

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.put(AuthController());

//     return Scaffold(
//       appBar: AppBar(title: const Text('Log In')),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Enter email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(labelText: 'Enter password'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final email = _emailController.text;
//                 final password = _passwordController.text;
//                 final user = await authController.signIn(email, password);

//                 if (user != null) {
//                   Get.offAllNamed('/home');  // Navigate to home screen
//                 } else {
//                   // Show error message
//                   Get.snackbar('Error', 'Invalid credentials');
//                 }
//               },
//               child: const Text('Log In'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Get.to(() =>  SignupScreen());  // Navigate to SignupScreen
//               },
//               child: const Text('Create Account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
import 'package:achno/Common%20Components/CommonButton.dart';
import 'package:achno/Common%20Components/CustomTextField.dart';
import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
               'assets/icons/Slogo.png', // replace with actual logo path
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome back! Sign in using your social account or email to continue us',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: numberController,
                hintText: 'Enter Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              Obx(
                () => CustomTextField(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: authController.isPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      authController.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => authController.togglePasswordVisibility(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Add forgot password logic
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Log in',
                onPressed: () {
                  authController.signIn(
                    numberController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Create Account',
                backgroundColor: Colors.grey.shade400,
                textColor: Colors.white,
                onPressed: () => Get.to(() => SignupScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
