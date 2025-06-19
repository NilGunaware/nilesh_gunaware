import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_view_model.dart';

class HomePage extends StatelessWidget {
  final vm = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: vm.logout,
            tooltip: 'Logout',
          )
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildInfoCard(),
              const SizedBox(height: 20),
              _buildFirestoreHintCard(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 30, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    vm.userEmail ?? "Loading...",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    final userData = vm.userData;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoRow('User ID', userData['uid'] ?? "N/A"),
            _buildInfoRow('Created At', _formatDate(userData['createdAt'])),
            _buildInfoRow('Last Login', _formatDate(userData['lastLogin'])),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text('$title: ', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[800])),
          ),
        ],
      ),
    );
  }

  Widget _buildFirestoreHintCard() {
    return Card(
      color: Colors.deepPurple[50],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.deepPurple),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Your data is stored in the "users" collection in Firebase Firestore, identified by your email address.',
                style: TextStyle(fontSize: 14, color: Colors.deepPurple[900]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return "N/A";
    try {
      return DateTime.parse(timestamp).toString().substring(0, 19);
    } catch (e) {
      return "Invalid date";
    }
  }
}
