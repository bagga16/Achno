import 'package:achno/App%20Screens/Auth%20Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/Auth Controller/AuthController.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Enter email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Enter password'),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm password'),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                final confirmPassword = _confirmPasswordController.text;

                if (password == confirmPassword) {
                  final user = await authController.signUp(email, password);

                  if (user != null) {
                    Get.offAllNamed('/home');  // Navigate to home screen
                  } else {
                    // Show error message
                    Get.snackbar('Error', 'Something went wrong');
                  }
                } else {
                  // Passwords do not match
                  Get.snackbar('Error', 'Passwords do not match');
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() =>  LoginScreen());  // Navigate to LoginScreen
              },
              child: const Text('Already have an account? Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
