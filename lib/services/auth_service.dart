import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final fbAuth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.ref('users');

  User? get currentUser => fbAuth.currentUser;

  bool isLoggedIn() => currentUser != null;

  Future<String?> signup(String email, String password) async {
    try {
      final cred = await fbAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // Store user data in Firebase Database
      await dbRef.child(cred.user!.uid).set({
        'email': email,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Signup failed: ${e.toString()}";
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await fbAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Login failed: ${e.toString()}";
    }
  }

  Future<void> logout() async {
    await fbAuth.signOut();
  }
}
