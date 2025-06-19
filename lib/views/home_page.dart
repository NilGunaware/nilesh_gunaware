import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_view_model.dart';

class HomePage extends StatelessWidget {
  final vm = Get.find<AuthViewModel>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout), 
            onPressed: vm.logout,
            tooltip: 'Logout',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email: ${vm.userEmail ?? "Loading..."}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        if (vm.userData.isNotEmpty) ...[
                          Text(
                            'User ID: ${vm.userData['uid'] ?? "N/A"}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Created: ${vm.userData['createdAt'] != null ? DateTime.parse(vm.userData['createdAt']).toString().substring(0, 19) : "N/A"}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Last Login: ${vm.userData['lastLogin'] != null ? DateTime.parse(vm.userData['lastLogin']).toString().substring(0, 19) : "N/A"}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ],
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Firebase Data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your data is stored in Firestore collection "users" with your email as the document ID.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
