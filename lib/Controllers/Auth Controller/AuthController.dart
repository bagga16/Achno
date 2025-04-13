
import 'dart:io';

import 'package:achno/App%20Screens/Auth%20Screens/UserDetailsScreen.dart';
import 'package:achno/App%20Screens/SplashScreen.dart';
import 'package:achno/Home.dart';
import 'package:achno/Models/User%20Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart'; // For handling image uploads

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  bool isLoggedIn() => _user.value != null;
  final RxBool isPasswordHidden = true.obs;
final RxBool isConfirmPasswordHidden = true.obs;

void togglePasswordVisibility() {
  isPasswordHidden.value = !isPasswordHidden.value;
}
void toggleConfirmPasswordVisibility() {
  isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
}

  // Sign in method
  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAll(() => Home());
      return userCredential.user;
    } catch (e) {
      return null; // Handle error
    }
  }

  // Sign up method
  Future<User?> signUp(String email, String password, String name,) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      // Create the user document in Firestore
      await _createUserInFirestore(
        userCredential.user!,
        name,
      email
            );

      Get.offAll(() => UserDetailsScreen());
      return userCredential.user;
    } catch (e) {
      return null; // Handle error
    }
  }

Future<void> saveUserData(UserModel userModel) async {
  await _firestore.collection('All Users').doc(userModel.uid).set(userModel.toMap());
}

  // Method to upload profile image to Firebase Storage
  Future<String> _uploadProfileImage(String imagePath) async {
    try {
      final file = XFile(imagePath);
      final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/${file.name}');
      await storageRef.putFile(File(file.path));

      return await storageRef.getDownloadURL();
    } catch (e) {
      return ''; // Return an empty string if the image upload fails
    }
  }


  // Method to create user data in Firestore
  Future<void> _createUserInFirestore(User user, String name, String profileImageUrl) async {
    try {
      await _firestore.collection('All Users').doc(user.uid).set({
        'email': user.email,
        'name': name,
        'profileImage': profileImageUrl,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print('Error storing user data in Firestore: $e');
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Delete account method
  Future<void> deleteAccount() async {
    try {
      // First, delete user data from Firestore
      if (_user.value != null) {
        await _firestore.collection('All Users').doc(_user.value!.uid).delete();
      }

      // Delete the user's account from Firebase Authentication
      await _user.value!.delete();
      // Sign out after deletion
      await _auth.signOut();
      Get.offAll(() => SplashScreen());
    } catch (e) {
      print('Error deleting account: $e');
    }
  }
}









////////////////// with phone
///
  // // ✅ LOGIN with number as email workaround
  // Future<User?> signIn(String phone, String password) async {
  //   final fakeEmail = "$phone@achno.app";
  //   try {
  //     final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: fakeEmail,
  //       password: password,
  //     );
  //     Get.offAll(() => Home());
  //     return userCredential.user;
  //   } catch (e) {
  //     Get.snackbar("Login Error", "Invalid phone or password");
  //     return null;
  //   }
  // }

  // // ✅ SIGNUP with phone as fake email
  // Future<User?> signUp(String phone, String password) async {
  //   final fakeEmail = "$phone@achno.app";
  //   try {
  //     final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: fakeEmail,
  //       password: password,
  //     );

  //     Get.offAll(() => Home());
  //     return userCredential.user;
  //   } catch (e) {
  //     Get.snackbar("Signup Error", "Phone number may already exist");
  //     return null;
  //   }
  // }