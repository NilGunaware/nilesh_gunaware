import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nilesh_gunaware/routes/app_routes.dart';
import 'package:nilesh_gunaware/viewmodels/auth_view_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
   try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    print('Firebase initialization error: $e');
   }

   Get.put(AuthViewModel());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Get.find<AuthViewModel>();
    
    return GetMaterialApp(
      title: 'Firebase Auth MVVM',
      debugShowCheckedModeBanner: false,
      initialRoute: authViewModel.isLoggedIn() ? '/home' : '/login',
      getPages: AppRoutes.routes,
    );
  }
}