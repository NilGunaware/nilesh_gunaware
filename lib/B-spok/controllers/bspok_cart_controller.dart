import 'package:get/get.dart';
import '../models/bspok_cart_model.dart';
import '../models/bspok_product_model.dart';
import '../services/bspok_api_service.dart';

class BSpokCartController extends GetxController {
  // Observable variables
  final RxList<BSpokCartItem> cartItems = <BSpokCartItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxDouble subtotal = 0.0.obs;
  final RxDouble tax = 0.0.obs;
  final RxDouble shipping = 0.0.obs;
  final RxDouble total = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  // Load cart from API
  Future<void> loadCart() async {
    try {
      isLoading.value = true;
      // Mock data for now - empty cart
      cartItems.clear();
      _calculateTotals();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cart: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Add item to cart
  Future<void> addToCart(BSpokProduct product, {
    int quantity = 1,
    String? selectedSize,
    String? selectedColor,
  }) async {
    try {
      isLoading.value = true;

      // Check if item already exists in cart
      final existingIndex = cartItems.indexWhere((item) => 
        item.productId == product.id &&
        item.selectedSize == selectedSize &&
        item.selectedColor == selectedColor
      );

      if (existingIndex != -1) {
        // Update quantity of existing item
        final existingItem = cartItems[existingIndex];
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        );
        cartItems[existingIndex] = updatedItem;
      } else {
        // Add new item to cart
        final newItem = BSpokCartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          productId: product.id,
          productName: product.name,
          productCode: product.code,
          productImage: product.images.isNotEmpty ? product.images.first : '',
          price: product.price,
          quantity: quantity,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
          inStock: product.inStock,
        );
        cartItems.add(newItem);
      }

      _calculateTotals();
      
      Get.snackbar(
        'Success',
        'Added to cart successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to add to cart: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update item quantity
  Future<void> updateQuantity(String itemId, int newQuantity) async {
    try {
      if (newQuantity <= 0) {
        await removeFromCart(itemId);
        return;
      }

      final index = cartItems.indexWhere((item) => item.id == itemId);
      if (index != -1) {
        final item = cartItems[index];
        final updatedItem = item.copyWith(quantity: newQuantity);
        cartItems[index] = updatedItem;
        _calculateTotals();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update quantity: $e');
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(String itemId) async {
    try {
      cartItems.removeWhere((item) => item.id == itemId);
      _calculateTotals();

      Get.snackbar(
        'Success',
        'Item removed from cart!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove item: $e');
    }
  }

  // Clear cart
  Future<void> clearCart() async {
    try {
      cartItems.clear();
      _calculateTotals();

      Get.snackbar(
        'Success',
        'Cart cleared!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to clear cart: $e');
    }
  }

  // Calculate totals
  void _calculateTotals() {
    subtotal.value = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    
    // Calculate tax (assuming 10% tax rate)
    tax.value = subtotal.value * 0.10;
    
    // Calculate shipping (free shipping for orders above 1000, else 50)
    shipping.value = subtotal.value >= 1000 ? 0.0 : 50.0;
    
    // Calculate total
    total.value = subtotal.value + tax.value + shipping.value;
  }

  // Get cart item count
  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Check if cart is empty
  bool get isCartEmpty => cartItems.isEmpty;

  // Get item by ID
  BSpokCartItem? getItemById(String itemId) {
    try {
      return cartItems.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }

  // Check if product is in cart
  bool isProductInCart(String productId) {
    return cartItems.any((item) => item.productId == productId);
  }

  // Get quantity of product in cart
  int getProductQuantity(String productId) {
    final item = cartItems.firstWhereOrNull((item) => item.productId == productId);
    return item?.quantity ?? 0;
  }

  // Refresh cart
  Future<void> refreshCart() async {
    await loadCart();
  }

  // Navigate to checkout
  void navigateToCheckout() {
    if (isCartEmpty) {
      Get.snackbar(
        'Empty Cart',
        'Please add items to your cart before checkout',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.toNamed('/bspok/checkout');
    }
  }

  // Navigate to product details
  void navigateToProductDetails(String productId) {
    Get.toNamed('/bspok/product/$productId');
  }

  // Navigate to home
  void navigateToHome() {
    Get.toNamed('/bspok/home');
  }
} 