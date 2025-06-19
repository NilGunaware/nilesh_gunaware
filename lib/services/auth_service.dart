import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;

   Future<bool> testFirebaseConnection() async {
    try {
      print('AuthService: Testing Firebase connection...');
      
       await _firestore.collection('test').limit(1).get();
      
       await _auth.authStateChanges().first;
      
      print('AuthService: Firebase connection test successful');
      return true;
    } catch (e) {
      print('AuthService: Firebase connection test failed - $e');
      return false;
    }
  }

  Future<String?> signup(String name, String Lname, String email, String password) async {
    try {
      final cleanEmail = email.trim().toLowerCase();
      print('AuthService: Signup attempt for email: $cleanEmail');
      
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: cleanEmail,
        password: password,
      );

      // Store user data in Firestore
      await _firestore.collection('users').doc(cleanEmail).set({
        'name': name,
        'lname': Lname,
        'email': cleanEmail,
        'uid': userCredential.user!.uid,
        'createdAt': DateTime.now().toIso8601String(),
        'lastLogin': DateTime.now().toIso8601String(),
      });

      print('AuthService: User created successfully: $cleanEmail');
      return null;
    } on FirebaseAuthException catch (e) {
      print('AuthService: Signup error - ${e.code}: ${e.message}');
      return _getErrorMessage(e.code);
    } catch (e) {
      print('AuthService: General signup error - $e');
      return 'An error occurred during signup';
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final cleanEmail = email.trim().toLowerCase();
      print('AuthService: Login attempt for email: $cleanEmail');
      
      await _auth.signInWithEmailAndPassword(
        email: cleanEmail,
        password: password,
      );

      // Update last login time
      await _firestore.collection('users').doc(cleanEmail).update({
        'lastLogin': DateTime.now().toIso8601String(),
      });

      print('AuthService: Login successful: $cleanEmail');
      return null;
    } on FirebaseAuthException catch (e) {
      print('AuthService: Login error - ${e.code}: ${e.message}');
      return _getErrorMessage(e.code);
    } catch (e) {
      print('AuthService: General login error - $e');
      return 'An error occurred during login';
    }
  }

  void logout() {
    print('AuthService: Logging out user: ${currentUser?.email}');
    _auth.signOut();
  }

  Future<Map<String, dynamic>?> getUserData(String email) async {
    try {
      final cleanEmail = email.trim().toLowerCase();
      print('AuthService: Fetching user data for: $cleanEmail');
      
      final doc = await _firestore.collection('users').doc(cleanEmail).get();
      if (doc.exists) {
        final data = doc.data()!;
        print('AuthService: User data retrieved successfully');
        return data;
      }
      print('AuthService: User data not found');
      return null;
    } catch (e) {
      print('AuthService: Error fetching user data - $e');
      return null;
    }
  }

  // Enhanced password reset method
  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      final cleanEmail = email.trim().toLowerCase();
      print('AuthService: Attempting to send password reset email to $cleanEmail');
      
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(cleanEmail)) {
        print('AuthService: Invalid email format: $cleanEmail');
        return 'Invalid email format';
      }
      
      final userDoc = await _firestore.collection('users').doc(cleanEmail).get();
      if (!userDoc.exists) {
        print('AuthService: User not found in database: $cleanEmail');
        return 'No account found with this email address';
      }
      
      await _auth.sendPasswordResetEmail(email: cleanEmail);
      
      print('AuthService: Password reset email sent successfully to: $cleanEmail');
      return null;
      
    } on FirebaseAuthException catch (e) {
      print('AuthService: Password reset error - ${e.code}: ${e.message}');
      return _getPasswordResetErrorMessage(e.code);
    } catch (e) {
      print('AuthService: General password reset error - $e');
      return 'An error occurred while sending the password reset email';
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  String _getPasswordResetErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many password reset attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'An error occurred while sending the password reset email.';
    }
  }
}
