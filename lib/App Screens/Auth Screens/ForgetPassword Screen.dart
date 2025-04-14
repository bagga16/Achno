import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:achno/Common%20Components/CommonButton.dart';
import 'package:achno/Common%20Components/CustomTextField.dart';
import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              child: Image.asset('assets/icons/Slogo.png', height: 90),
            ),
            const SizedBox(height: 20),
            const Text(
              'Forgot Password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Enter your registered email address to get verification code',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Send',
              onPressed: () async {
                try {
                  await Get.find<AuthController>()
                      .sendPasswordReset(emailController.text.trim());
                  Get.snackbar('Success', 'Reset link sent to your email');
                } catch (e) {
                  Get.snackbar('Error', 'Failed to send reset email');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
