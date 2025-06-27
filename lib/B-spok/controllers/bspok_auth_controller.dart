import 'package:get/get.dart';
import '../models/bspok_user_model.dart';
import '../services/bspok_api_service.dart';

class BSpokAuthController extends GetxController {
  // Observable variables
  final Rx<BSpokUser?> currentUser = Rx<BSpokUser?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString authToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  // Check if user is already logged in
  Future<void> checkAuthStatus() async {
    try {
      // Check if token exists in storage
      final token = await BSpokApiService.getStoredToken();
      if (token != null && token.isNotEmpty) {
        authToken.value = token;
        await getCurrentUser();
      }
    } catch (e) {
      print('Error checking auth status: $e');
    }
  }

  // Login user
  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      
      // Mock login for testing
      if (email == 'test@example.com' && password == 'password') {
        final mockUser = BSpokUser(
          id: '1',
          email: email,
          name: 'Test User',
          firstName: 'Test',
          lastName: 'User',
          phoneNumber: '+1234567890',
          isEmailVerified: true,
          isPhoneVerified: false,
          userType: 'customer',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        currentUser.value = mockUser;
        authToken.value = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
        isLoggedIn.value = true;
        
        // Store token
        await BSpokApiService.storeToken(authToken.value);
        
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
        );
        
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Invalid credentials. Use test@example.com / password',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Register user
  Future<bool> register(String name, String email, String password, String phone) async {
    try {
      isLoading.value = true;
      
      final response = await BSpokApiService.register(name, email, password, phone);
      currentUser.value = response['user'];
      authToken.value = response['token'];
      isLoggedIn.value = true;
      
      // Store token
      await BSpokApiService.storeToken(authToken.value);
      
      Get.snackbar(
        'Success',
        'Registration successful!',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      isLoading.value = true;
      
      // Clear stored token
      await BSpokApiService.clearStoredToken();
      
      // Reset state
      currentUser.value = null;
      authToken.value = '';
      isLoggedIn.value = false;
      
      Get.snackbar(
        'Success',
        'Logged out successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      // Navigate to login page
      Get.offAllNamed('/bspok/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Logout failed: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get current user details
  Future<void> getCurrentUser() async {
    try {
      // Mock user data
      final mockUser = BSpokUser(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        firstName: 'Test',
        lastName: 'User',
        phoneNumber: '+1234567890',
        isEmailVerified: true,
        isPhoneVerified: false,
        userType: 'customer',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      currentUser.value = mockUser;
      isLoggedIn.value = true;
    } catch (e) {
      print('Error getting current user: $e');
      // If getting user fails, logout
      await logout();
    }
  }

  // Update user profile
  Future<bool> updateProfile(Map<String, dynamic> userData) async {
    try {
      isLoading.value = true;
      
      final updatedUser = await BSpokApiService.updateUserProfile(
        currentUser.value!.id,
        userData,
      );
      
      currentUser.value = updatedUser;
      
      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot password
  Future<bool> forgotPassword(String email) async {
    try {
      isLoading.value = true;
      
      await BSpokApiService.forgotPassword(email);
      
      Get.snackbar(
        'Success',
        'Password reset link sent to your email!',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send reset link: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Reset password
  Future<bool> resetPassword(String token, String newPassword) async {
    try {
      isLoading.value = true;
      
      await BSpokApiService.resetPassword(token, newPassword);
      
      Get.snackbar(
        'Success',
        'Password reset successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reset password: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Change password
  Future<bool> changePassword(String currentPassword, String newPassword) async {
    try {
      isLoading.value = true;
      
      await BSpokApiService.changePassword(currentPassword, newPassword);
      
      Get.snackbar(
        'Success',
        'Password changed successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to change password: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Check if user is authenticated
  bool get isAuthenticated => isLoggedIn.value && currentUser.value != null;

  // Get user ID
  String? get userId => currentUser.value?.id;

  // Get user name
  String? get userName => currentUser.value?.name;

  // Get user email
  String? get userEmail => currentUser.value?.email;
} 