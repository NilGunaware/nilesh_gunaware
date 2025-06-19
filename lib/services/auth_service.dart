import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final fbAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  User? get currentUser => fbAuth.currentUser;

  bool isLoggedIn() => currentUser != null;

  Future<String?> signup(String email, String password) async {
    try {
      // Create user with Firebase Auth
      final cred = await fbAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // Store user data in Firestore with email as document ID
      await firestore.collection('users').doc(email).set({
        'email': email,
        'password': password, // Note: In production, never store passwords in plain text
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
      // Sign in with Firebase Auth
      await fbAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // Update last login time in Firestore
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

  // Get user data from Firestore
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
