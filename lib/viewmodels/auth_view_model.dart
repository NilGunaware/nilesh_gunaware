import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthViewModel extends GetxController {
  final AuthService _authService = AuthService();

  var isLoading = false.obs;

  bool isLoggedIn() => _authService.isLoggedIn();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await _authService.login(email, password);
    isLoading.value = false;

    if (result == "success") {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Error", result);
    }
  }

  void logout() {
    _authService.logout();
    Get.offAllNamed('/login');
  }

  void signup(String email, String password) {
    _authService.register(email, password);
    Get.offAllNamed('/home');
  }
}
