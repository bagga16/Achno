import 'package:achno/App%20Screens/Auth%20Screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/Auth Controller/AuthController.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
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
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                final user = await authController.signIn(email, password);

                if (user != null) {
                  Get.offAllNamed('/home');  // Navigate to home screen
                } else {
                  // Show error message
                  Get.snackbar('Error', 'Invalid credentials');
                }
              },
              child: const Text('Log In'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() =>  SignupScreen());  // Navigate to SignupScreen
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
