import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:achno/Common%20Components/CommonButton.dart';
import 'package:achno/Common%20Components/CustomTextField.dart';
import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final AuthController authController = Get.find();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

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
              'Reset Password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Enter your new password and confirm password',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Obx(() => TextField(
                  controller: passwordController,
                  obscureText: authController.isPasswordHidden.value,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(authController.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: authController.togglePasswordVisibility,
                    ),
                  ),
                )),
            const SizedBox(height: 15),
            Obx(() => TextField(
                  controller: confirmController,
                  obscureText: authController.isConfirmPasswordHidden.value,
                  decoration: InputDecoration(
                    hintText: 'Enter confirm password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(authController.isConfirmPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: authController.toggleConfirmPasswordVisibility,
                    ),
                  ),
                )),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Confirm',
              onPressed: () async {
                final pass = passwordController.text.trim();
                final confirm = confirmController.text.trim();

                if (pass != confirm) {
                  Get.snackbar('Error', 'Passwords do not match');
                  return;
                }

                try {
                  await authController.updatePassword(pass);
                  Get.snackbar('Success', 'Password updated');
                  Get.offAllNamed('/login');
                } catch (e) {
                  Get.snackbar('Error', 'Could not update password');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
