import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_view_model.dart';

class HomePage extends StatelessWidget {
  final info = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('HomePage'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: info.logout,
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
      elevation: 8,
      shadowColor: Colors.indigo.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.indigo[100],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.indigo,
              child: const Icon(Icons.person, size: 30, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${info.userData['name'] ?? ""} ${info.userData['lname'] ?? ""}',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  if (info.userData['email'] != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      info.userEmail ?? "",
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    final userData = info.userData;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '👤 Account Details',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900]),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            _buildInfoRow('Name',
                '${userData['name'] ?? "N/A"} ${userData['lname'] ?? ""}'),
            _buildInfoRow('Email', userData['email'] ?? "N/A"),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(
            '$title:',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[800]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirestoreHintCard() {
    return Card(
      color: Colors.green[50],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.cloud_done, color: Colors.green),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '✅ Data is successfully stored in the Firebase "User" collection.',
                style: TextStyle(fontSize: 14, color: Colors.green[900]),
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
