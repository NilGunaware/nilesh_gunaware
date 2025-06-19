import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_view_model.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthViewModel _authViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
           IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () => _testFirebaseConnection(),
            tooltip: 'Test Firebase Connection',
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              elevation: 10,
              shadowColor: Colors.indigo.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_reset, size: 48, color: Colors.indigo),
                      const SizedBox(height: 10),
                      Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[800],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Enter your email to receive a password reset link",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                       TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: _inputDecoration("Email", Icons.email),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          
                           final cleanEmail = value.trim().toLowerCase();
                          
                           final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(cleanEmail)) {
                            return "Please enter a valid email address";
                          }
                          
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                       Obx(() => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _authViewModel.isLoading.value
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                     final cleanEmail = _emailController.text.trim().toLowerCase();
                                    print('Sending password reset to clean email: $cleanEmail');
                                    _authViewModel.forgotPassword(cleanEmail);
                                  }
                                },
                          child: _authViewModel.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text("Send Reset Link", style: TextStyle(fontSize: 16)),
                        ),
                      )),

                      const SizedBox(height: 16),
                      
                       TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "Back to Login",
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.indigo[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

   void _testFirebaseConnection() async {
    try {
      Get.snackbar(
        "Testing Connection",
        "Checking Firebase connectivity...",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue[100],
        colorText: Colors.black87,
        duration: const Duration(seconds: 2),
      );
      
       await _authViewModel.forgotPassword("test@gmail.com");
      
    } catch (e) {
      Get.snackbar(
        "Debug Info",
        "Error: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
        colorText: Colors.black87,
        duration: const Duration(seconds: 5),
      );
    }
  }
} 