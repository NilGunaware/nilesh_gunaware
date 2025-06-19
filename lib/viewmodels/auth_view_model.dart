import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthViewModel extends GetxController {
  final _auth = AuthService();
  var isLoading = false.obs;
  var userData = <String, dynamic>{}.obs;

  bool isLoggedIn() => _auth.isLoggedIn;
  String? get userEmail => _auth.currentUser?.email;

  @override
  void onInit() {
    super.onInit();
    if (isLoggedIn()) {
      loadUserData();
    }
  }

  Future<void> loadUserData() async {
    if (userEmail != null) {
      final data = await _auth.getUserData(userEmail!);
      if (data != null) {
        userData.value = data;
      }
    }
  }

  Future<void> signup(String name, String Lname ,String email, String pass ) async {
    isLoading.value = true;
    final err = await _auth.signup(name, Lname,email, pass);
    isLoading.value = false;
    if (err == null) {
      await loadUserData();
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Signup Error", err);
    }
  }

  Future<void> login(String email, String pass) async {
    isLoading.value = true;
    final err = await _auth.login(email, pass);
    isLoading.value = false;
    if (err == null) {
      await loadUserData();
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Login Error", err);
    }
  }

  void logout() {
    _auth.logout();
    userData.clear();
    Get.offAllNamed('/login');
  }

   bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> forgotPassword(String email) async {
    isLoading.value = true;
    try {
       final cleanEmail = email.trim().toLowerCase();
      print('AuthViewModel: Starting password reset for email: $cleanEmail');
      
       if (!_isValidEmail(cleanEmail)) {
        Get.snackbar(
          "Invalid Email",
          "Please enter a valid email address",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black87,
          duration: const Duration(seconds: 5),
        );
        return;
      }
      
      print('  Email validation passed: $cleanEmail');
      
       final isConnected = await _auth.testFirebaseConnection();
      if (!isConnected) {
        Get.snackbar(
          "Connection Error",
          "Unable to connect to Firebase. Please check your internet connection.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black87,
          duration: const Duration(seconds: 5),
        );
        return;
      }
      
      print('AuthViewModel: Firebase connection test passed');
      
       final error = await _auth.sendPasswordResetEmail(cleanEmail);
      
      if (error != null) {
        print('AuthViewModel: Password reset error: $error');
        Get.snackbar(
          "Error",
          error,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.black87,
          duration: const Duration(seconds: 5),
        );
        return;
      }
      
      print('  Password reset email sent successfully to: $cleanEmail');
      
       Get.snackbar(
        "Success!",
        "Password reset link sent to $cleanEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.black87,
        duration: const Duration(seconds: 4),
      );
      

      
    } catch (e) {
      print('AuthViewModel: General Error - $e');
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again later.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.black87,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
