import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_view_model.dart';

class HomePage extends StatelessWidget {
  final AuthViewModel _authViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    final userEmail = _authViewModel.getLoggedInEmail();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () => _authViewModel.logout(),
            icon: Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 24),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, size: 48, color: Colors.blue),
                SizedBox(height: 16),
                Text(
                  "Welcome to Home Page!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                if (userEmail != null)
                  Text(
                    "Logged in as: $userEmail",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
