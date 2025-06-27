import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bspok_user_model.dart';
import '../models/bspok_product_model.dart';
import '../models/bspok_category_model.dart';
import '../models/bspok_cart_model.dart';
import '../models/bspok_order_model.dart';
import '../models/bspok_banner_model.dart';

class BSpokApiService {
  static const String baseUrl = 'https://api.bspok.com'; // Replace with your actual API URL
  static const String apiVersion = '/api/v1';
  static const String tokenKey = 'bspok_auth_token';
  static const String userKey = 'bspok_user_data';

  // HTTP Client
  static final http.Client _client = http.Client();

  // Headers
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> get _authHeaders {
    final token = getStoredToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Token Management
  static Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<void> clearStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userKey);
  }

  // Error Handler
  static void _handleError(http.Response response) {
    if (response.statusCode >= 400) {
      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'An error occurred');
    }
  }

  // Authentication APIs
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$apiVersion/auth/login'),
        headers: _headers,
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      _handleError(response);
      final data = json.decode(response.body);
      return {
        'user': BSpokUser.fromJson(data['user']),
        'token': data['token'],
      };
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$apiVersion/auth/register'),
        headers: _headers,
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        }),
      );

      _handleError(response);
      final data = json.decode(response.body);
      return {
        'user': BSpokUser.fromJson(data['user']),
        'token': data['token'],
      };
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  static Future<BSpokUser> getCurrentUser() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/auth/me'),
        headers: _authHeaders,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return BSpokUser.fromJson(data['user']);
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  static Future<void> forgotPassword(String email) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$apiVersion/auth/forgot-password'),
        headers: _headers,
        body: json.encode({'email': email}),
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to send reset link: $e');
    }
  }

  static Future<void> resetPassword(String token, String newPassword) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$apiVersion/auth/reset-password'),
        headers: _headers,
        body: json.encode({
          'token': token,
          'password': newPassword,
        }),
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  static Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$apiVersion/auth/change-password'),
        headers: _authHeaders,
        body: json.encode({
          'current_password': currentPassword,
          'new_password': newPassword,
        }),
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  static Future<BSpokUser> updateUserProfile(String userId, Map<String, dynamic> userData) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl$apiVersion/users/$userId'),
        headers: _authHeaders,
        body: json.encode(userData),
      );

      _handleError(response);
      final data = json.decode(response.body);
      return BSpokUser.fromJson(data['user']);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // Product APIs
  static Future<List<BSpokProduct>> getProducts({
    String? categoryId,
    String? search,
    String? sortBy,
    String? sortOrder,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        if (categoryId != null) 'category_id': categoryId,
        if (search != null) 'search': search,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
      };

      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/products').replace(queryParameters: queryParams),
        headers: _headers,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return (data['products'] as List)
          .map((product) => BSpokProduct.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  static Future<BSpokProduct> getProductById(String productId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/products/$productId'),
        headers: _headers,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return BSpokProduct.fromJson(data['product']);
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  static Future<List<BSpokProduct>> getNewArrivals() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/products/new-arrivals'),
        headers: _headers,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return (data['products'] as List)
          .map((product) => BSpokProduct.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to get new arrivals: $e');
    }
  }

  static Future<List<BSpokProduct>> getFeaturedProducts() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/products/featured'),
        headers: _headers,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return (data['products'] as List)
          .map((product) => BSpokProduct.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to get featured products: $e');
    }
  }

  // Category APIs
  static Future<List<BSpokCategory>> getCategories() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/categories'),
        headers: _headers,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return (data['categories'] as List)
          .map((category) => BSpokCategory.fromJson(category))
          .toList();
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  static Future<BSpokCategory> getCategoryById(String categoryId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/categories/$categoryId'),
        headers: _headers,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return BSpokCategory.fromJson(data['category']);
    } catch (e) {
      throw Exception('Failed to get category: $e');
    }
  }

  // Banner APIs
  static Future<List<BSpokBanner>> getBanners() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/banners'),
        headers: _headers,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return (data['banners'] as List)
          .map((banner) => BSpokBanner.fromJson(banner))
          .toList();
    } catch (e) {
      throw Exception('Failed to get banners: $e');
    }
  }

  // Cart APIs
  static Future<BSpokCart> getCart() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/cart'),
        headers: _authHeaders,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return BSpokCart.fromJson(data['cart']);
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  static Future<void> addToCart({
    required String productId,
    required int quantity,
    String? selectedSize,
    String? selectedColor,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$apiVersion/cart/add'),
        headers: _authHeaders,
        body: json.encode({
          'product_id': productId,
          'quantity': quantity,
          'selected_size': selectedSize,
          'selected_color': selectedColor,
        }),
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  static Future<void> updateCartItem(String itemId, int quantity) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl$apiVersion/cart/items/$itemId'),
        headers: _authHeaders,
        body: json.encode({'quantity': quantity}),
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to update cart item: $e');
    }
  }

  static Future<void> removeFromCart(String itemId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl$apiVersion/cart/items/$itemId'),
        headers: _authHeaders,
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  static Future<void> clearCart() async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl$apiVersion/cart'),
        headers: _authHeaders,
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  // Order APIs
  static Future<List<BSpokOrder>> getOrders() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/orders'),
        headers: _authHeaders,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return (data['orders'] as List)
          .map((order) => BSpokOrder.fromJson(order))
          .toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  static Future<BSpokOrder> getOrderById(String orderId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/orders/$orderId'),
        headers: _authHeaders,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return BSpokOrder.fromJson(data['order']);
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  static Future<BSpokOrder> createOrder({
    required String shippingAddress,
    required String paymentMethod,
    String? couponCode,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$apiVersion/orders'),
        headers: _authHeaders,
        body: json.encode({
          'shipping_address': shippingAddress,
          'payment_method': paymentMethod,
          'coupon_code': couponCode,
        }),
      );

      _handleError(response);
      final data = json.decode(response.body);
      return BSpokOrder.fromJson(data['order']);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  static Future<void> cancelOrder(String orderId) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$apiVersion/orders/$orderId/cancel'),
        headers: _authHeaders,
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }

  // Search API
  static Future<List<BSpokProduct>> searchProducts(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$apiVersion/search').replace(queryParameters: {'q': query}),
        headers: _headers,
      );

      _handleError(response);
      final data = json.decode(response.body);
      return (data['products'] as List)
          .map((product) => BSpokProduct.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  // Close HTTP client
  static void dispose() {
    _client.close();
  }
} 