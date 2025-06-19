import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_view_model.dart';

class HomePage extends StatelessWidget {
  final vm = Get.find<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(icon: Icon(Icons.logout), onPressed: vm.logout)
      ]),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome, ${vm.userEmail}', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
