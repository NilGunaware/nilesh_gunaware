import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

class HomeViewModel extends GetxController {
  var categories = <CategoryModel>[].obs;
  var products = <ProductModel>[].obs;
  var cart = <String, int>{}.obs; // productId -> quantity

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void loadMockData() {
    categories.value = [
      CategoryModel(id: '1', name: 'Suiting', imageUrl: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f'),
      CategoryModel(id: '2', name: 'Fancy', imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb'),
      CategoryModel(id: '3', name: 'Wool', imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca'),
      CategoryModel(id: '4', name: 'All Seasons', imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca'),
    ];
    products.value = [
      ProductModel(id: '001', name: 'IDSH - 0012', imageUrl: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f', price: 340, isNew: true),
      ProductModel(id: '002', name: 'IDSH - 0013', imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb', price: 350, isNew: true),
      ProductModel(id: '003', name: 'IDSH - 0014', imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca', price: 370),
      ProductModel(id: '004', name: 'IDSH - 0015', imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca', price: 390),
    ];
  }

  void addToCart(String productId) {
    cart[productId] = (cart[productId] ?? 0) + 1;
  }

  void removeFromCart(String productId) {
    if (cart[productId] != null && cart[productId]! > 0) {
      cart[productId] = cart[productId]! - 1;
      if (cart[productId] == 0) cart.remove(productId);
    }
  }

  int getCartQuantity(String productId) {
    return cart[productId] ?? 0;
  }

  void incrementQuantity(String productId) {
    addToCart(productId);
  }

  void decrementQuantity(String productId) {
    removeFromCart(productId);
  }
}