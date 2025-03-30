import 'package:achno/App%20Screens/Home%20Screens/Home%20Screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  bool isLoggedIn() => _user.value != null;

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
        Get.offAll(() => HomeScreen());
      return userCredential.user;
    } catch (e) {
      return null; // Handle error
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
        Get.offAll(() => HomeScreen());
      return userCredential.user;
    } catch (e) {
      return null; // Handle error
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
