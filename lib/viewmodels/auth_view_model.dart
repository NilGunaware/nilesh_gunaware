import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthViewModel extends GetxController {
  final _auth = AuthService();
  var isLoading = false.obs;
  var userData = <String, dynamic>{}.obs;

  bool isLoggedIn() => _auth.isLoggedIn();
  String? get userEmail => _auth.currentUser?.email;

  @override
  void onInit() {
    super.onInit();
    // Load user data if logged in
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

  Future<void> signup(String email, String pass) async {
    isLoading.value = true;
    final err = await _auth.signup(email, pass);
    isLoading.value = false;
    if (err == null) {
      await loadUserData(); // Load user data after successful signup
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
      await loadUserData(); // Load user data after successful login
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Login Error", err);
    }
  }

  void logout() {
    _auth.logout();
    userData.clear(); // Clear user data on logout
    Get.offAllNamed('/login');
  }
}
