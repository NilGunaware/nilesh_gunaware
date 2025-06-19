import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final fbAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  User? get currentUser => fbAuth.currentUser;

  bool isLoggedIn() => currentUser != null;

  Future<String?> signup(String name, String email, String password) async {
    try {
       final cred = await fbAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
       await firestore.collection('users').doc(email).set({
        'name': name,
        'email': email,
        'password': password,
        'uid': cred.user!.uid,
        'createdAt': DateTime.now().toIso8601String(),
        'lastLogin': DateTime.now().toIso8601String(),
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
      
       await firestore.collection('users').doc(email).update({
        'lastLogin': DateTime.now().toIso8601String(),
      });
      
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

   Future<Map<String, dynamic>?> getUserData(String email) async {
    try {
      final doc = await firestore.collection('users').doc(email).get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }
}
