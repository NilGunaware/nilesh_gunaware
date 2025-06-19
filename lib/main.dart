import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'viewmodels/auth_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthViewModel authViewModel = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      initialRoute: authViewModel.isLoggedIn() ? Routes.HOME : Routes.LOGIN,
      getPages: AppRoutes.routes,
    );
  }
}
