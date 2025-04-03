import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _serviceType;
  final List<String> _serviceTypes = ['Plumber', 'Electrician', 'Driver', 'Chef'];
  String fullName = 'Sofia Marouan';
  String phoneNumber = '+212 623 458 789';
  String city = 'Casablanca';
  String textInfo = 'Text info here...';
  String videoIntro = 'Video Intro info here...';

  XFile? _profilePic;

  // Function to pick profile picture
  Future<void> _pickProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profilePic = pickedFile;
    });
  }

  // Save changes (for demonstration purposes, it just prints the data)
  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Process the form data (e.g., save to backend)
      print("Profile Saved");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Profile Picture
              InkWell(
                onTap: _pickProfilePicture,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePic != null
                      ? FileImage(_profilePic!.path as File)
                      : const NetworkImage('https://via.placeholder.com/150') as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              // Full Name
              TextFormField(
                initialValue: fullName,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  fullName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Phone Number
              TextFormField(
                initialValue: phoneNumber,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  phoneNumber = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // City
              TextFormField(
                initialValue: city,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  city = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Service Type Dropdown
              DropdownButtonFormField<String>(
                value: _serviceType ?? _serviceTypes[0],
                decoration: const InputDecoration(
                  labelText: 'Service Type',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _serviceType = newValue;
                  });
                },
                items: _serviceTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your service type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Text Info
              TextFormField(
                initialValue: textInfo,
                decoration: const InputDecoration(
                  labelText: 'Text Info',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  textInfo = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text info';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Video Intro
              TextFormField(
                initialValue: videoIntro,
                decoration: const InputDecoration(
                  labelText: 'Video Intro',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  videoIntro = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your video intro';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Save Button
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
