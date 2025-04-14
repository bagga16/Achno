// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _serviceType;
//   final List<String> _serviceTypes = ['Plumber', 'Electrician', 'Driver','Seller','Chef'];
//   String fullName = 'Sofia Marouan';
//   String phoneNumber = '+212 623 458 789';
//   String city = 'Casablanca';
//   String textInfo = 'Text info here...';
//   String videoIntro = 'Video Intro info here...';

//   XFile? _profilePic;

//   // Function to pick profile picture
//   Future<void> _pickProfilePicture() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _profilePic = pickedFile;
//     });
//   }

//   // Save changes (for demonstration purposes, it just prints the data)
//   void _saveProfile() {
//     if (_formKey.currentState!.validate()) {
//       // Process the form data (e.g., save to backend)
//       print("Profile Saved");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // Profile Picture
//               InkWell(
//                 onTap: _pickProfilePicture,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _profilePic != null
//                       ? FileImage(_profilePic!.path as File)
//                       : const NetworkImage('https://via.placeholder.com/150') as ImageProvider,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Full Name
//               TextFormField(
//                 initialValue: fullName,
//                 decoration: const InputDecoration(
//                   labelText: 'Full Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   fullName = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your full name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12),
//               // Phone Number
//               TextFormField(
//                 initialValue: phoneNumber,
//                 decoration: const InputDecoration(
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   phoneNumber = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12),
//               // City
//               TextFormField(
//                 initialValue: city,
//                 decoration: const InputDecoration(
//                   labelText: 'City',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   city = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your city';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12),
//               // Service Type Dropdown
//               DropdownButtonFormField<String>(
//                 value: _serviceType ?? _serviceTypes[0],
//                 decoration: const InputDecoration(
//                   labelText: 'Service Type',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (newValue) {
//                   setState(() {
//                     _serviceType = newValue;
//                   });
//                 },
//                 items: _serviceTypes.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select your service type';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12),
//               // Text Info
//               TextFormField(
//                 initialValue: textInfo,
//                 decoration: const InputDecoration(
//                   labelText: 'Text Info',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   textInfo = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text info';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12),
//               // Video Intro
//               TextFormField(
//                 initialValue: videoIntro,
//                 decoration: const InputDecoration(
//                   labelText: 'Video Intro',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   videoIntro = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your video intro';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               // Save Button
//               ElevatedButton(
//                 onPressed: _saveProfile,
//                 child: const Text('Save Profile'),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:achno/Controllers/Auth%20Controller/AuthController.dart';
import 'package:achno/Controllers/Profile%20Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final ProfileController profileController = Get.put(ProfileController());

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final textInfoController = TextEditingController();
  final voiceInfoController = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUserModel.value;

    if (user != null) {
      fullNameController.text = user.fullName;
      phoneController.text = user.phone;
      cityController.text = user.city;
      textInfoController.text = user.textInfo;
      voiceInfoController.text = user.videoIntro;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final picked = profileController.pickedImage.value;
          final user = authController.currentUserModel.value;

          return Column(
            children: [
              // Header + Avatar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () => Get.back(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: picked != null
                    ? FileImage(File(picked.path))
                    : (user != null && user.profileImage.isNotEmpty
                        ? NetworkImage(user.profileImage)
                        : const NetworkImage('https://via.placeholder.com/150')) as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () => profileController.pickImage(),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.edit, size: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Name, role, city
              Text(
                user?.fullName ?? "Your Name",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF16706E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  user?.activity ?? 'Your Role',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(height: 4),
              Text(user?.city ?? 'Your City', style: const TextStyle(color: Colors.grey)),

              const SizedBox(height: 20),

              // Form
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF16706E),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: ListView(
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 16),

                      _inputField('Full Name', fullNameController),
                      const SizedBox(height: 12),
                      _inputField('Phone Number', phoneController),
                      const SizedBox(height: 12),
                      _inputField('City', cityController),
                      const SizedBox(height: 12),
                      _inputField('Text Info', textInfoController),
                      const SizedBox(height: 12),
                      _inputField('Voice Intro', voiceInfoController),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          profileController.saveProfile(
                            fullName: fullNameController.text,
                            phone: phoneController.text,
                            city: cityController.text,
                            activity: user?.activity ?? '',
                            textInfo: textInfoController.text,
                            videoIntro: voiceInfoController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF16706E),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text('Save Profile'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.teal.shade700,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
