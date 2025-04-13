import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';
import 'package:achno/Models/User%20Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatelessWidget {
  UserDetailsScreen({super.key});

  final AuthController authController = Get.find();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final RxString selectedActivity = ''.obs;
  final RxString selectedLocation = ''.obs;

  final activities = ['Plumber', 'Electrician', 'Driver', 'Seller', 'Other'];
  final locations = ['Downtown', 'North Zone', 'East Side', 'Suburbs'];

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
              'Personal Details',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Enter Your Personal Details.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                hintText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            Obx(() => DropdownButtonFormField<String>(
                  value: selectedActivity.value.isEmpty ? null : selectedActivity.value,
                  decoration: const InputDecoration(
                    hintText: 'Activity/Profession',
                    border: OutlineInputBorder(),
                  ),
                  items: activities
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => selectedActivity.value = value ?? '',
                )),
            const SizedBox(height: 15),

            Obx(() => DropdownButtonFormField<String>(
                  value: selectedLocation.value.isEmpty ? null : selectedLocation.value,
                  decoration: const InputDecoration(
                    hintText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                  items: locations
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => selectedLocation.value = value ?? '',
                )),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final user = UserModel(
                    uid: authController.user!.uid,
                    phone: phoneController.text.trim(),
                    city: cityController.text.trim(),
                    activity: selectedActivity.value,
                    location: selectedLocation.value,
                    profileImage: '',
                  );

                  await authController.saveUserData(user);
                  Get.offAllNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16706E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Finish', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
