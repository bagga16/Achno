
import 'dart:io';

import 'package:achno/App%20Screens/Auth%20Screens/UserDetailsScreen.dart';
import 'package:achno/App%20Screens/SplashScreen.dart';
import 'package:achno/Home.dart';
import 'package:achno/Models/User%20Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  final Rx<UserModel?> currentUserModel = Rx<UserModel?>(null);

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

Future<void> fetchUserData() async {
  final uid = _auth.currentUser?.uid;
  if (uid != null) {
    final doc = await _firestore.collection('All Users').doc(uid).get();
    if (doc.exists) {
      currentUserModel.value = UserModel.fromMap(doc.data()!);
    }
  }
}

Future<String> uploadProfileImage(String path) async {
  final file = File(path);
  final fileName = file.path.split('/').last;
  final ref = FirebaseStorage.instance.ref().child('profile_pictures/$fileName');
  await ref.putFile(file);
  return await ref.getDownloadURL();
}

Future<void> updateUserProfile(UserModel userModel) async {
  await _firestore.collection('All Users').doc(userModel.uid).update(userModel.toMap());
  currentUserModel.value = userModel;
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

  // Send password reset email
Future<void> sendPasswordReset(String email) async {
  try {
    if (email.trim().isEmpty) throw FirebaseAuthException(code: 'invalid-email');

    await _auth.sendPasswordResetEmail(email: email.trim());
    Get.snackbar('Success', 'Reset email sent to $email');
  } on FirebaseAuthException catch (e) {
    String msg = 'Something went wrong';
    if (e.code == 'user-not-found') {
      msg = 'No account found with this email';
    } else if (e.code == 'invalid-email') {
      msg = 'Enter a valid email';
    }
    Get.snackbar('Error', msg);
  } catch (e) {
    Get.snackbar('Error', 'Could not send reset email');
    print('Reset error: $e');
  }
}


// Update current password
Future<void> updatePassword(String newPassword) async {
  final user = _auth.currentUser;
  if (user != null) {
    await user.updatePassword(newPassword);
  } else {
    throw FirebaseAuthException(
      code: 'not-logged-in',
      message: 'No user is currently logged in.',
    );
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