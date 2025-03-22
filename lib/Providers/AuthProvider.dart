
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

final authProvider = Provider<AuthController>((ref) {
  return AuthController(FirebaseAuth.instance);
});

class AuthController {
  final FirebaseAuth _auth;

  AuthController(this._auth);

  bool isLoggedIn() {
    return _auth.currentUser != null; // Check if user is logged in
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      return userCredential.user;
    } catch (e) {
      return null; // Handle error
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
