import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthViewModel extends GetxController {
  final _auth = AuthService();
  var isLoading = false.obs;

  bool isLoggedIn() => _auth.isLoggedIn();
  String? get userEmail => _auth.currentUser?.email;

  Future<void> signup(String email, String pass) async {
    isLoading.value = true;
    final err = await _auth.signup(email, pass);
    isLoading.value = false;
    if (err == null) {
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
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Login Error", err);
    }
  }

  void logout() {
    _auth.logout();
    Get.offAllNamed('/login');
  }
}
