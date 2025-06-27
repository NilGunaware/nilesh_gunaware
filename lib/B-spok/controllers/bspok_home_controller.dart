import 'package:get/get.dart';
import '../models/bspok_product_model.dart';
import '../models/bspok_category_model.dart';
import '../models/bspok_banner_model.dart';
import '../services/bspok_api_service.dart';
import 'package:flutter/material.dart';

class BSpokHomeController extends GetxController {
  // Observable variables
  final RxList<BSpokProduct> products = <BSpokProduct>[].obs;
  final RxList<BSpokProduct> filteredProducts = <BSpokProduct>[].obs;
  final RxList<BSpokCategory> categories = <BSpokCategory>[].obs;
  final RxList<BSpokBanner> banners = <BSpokBanner>[].obs;
  final RxList<BSpokProduct> newArrivals = <BSpokProduct>[].obs;
  final RxList<BSpokProduct> featuredProducts = <BSpokProduct>[].obs;
  
  final RxBool isLoading = false.obs;
  final RxBool isPriceVisible = true.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = ''.obs;
  final RxString sortBy = 'name'.obs;
  final RxString sortOrder = 'asc'.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  // Load all home page data
  Future<void> loadHomeData() async {
    try {
      isLoading.value = true;
      
      // Load data in parallel
      await Future.wait([
        loadCategories(),
        loadBanners(),
        loadNewArrivals(),
        loadFeaturedProducts(),
        loadProducts(),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load home data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Load categories
  Future<void> loadCategories() async {
    try {
      // Mock data for now
      categories.value = [
        BSpokCategory(
          id: '1',
          name: 'SUITING',
          description: 'Premium suiting fabrics',
          imageUrl: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
          order: 1,
          isActive: true,
          productCount: 25,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        BSpokCategory(
          id: '2',
          name: 'WOOL',
          description: 'High-quality wool fabrics',
          imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
          order: 2,
          isActive: true,
          productCount: 18,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  // Load banners
  Future<void> loadBanners() async {
    try {
      // Mock data for now
      banners.value = [
        BSpokBanner(
          id: '1',
          title: 'THE B-SPOK BOX',
          imageUrl: 'https://media.istockphoto.com/id/1318246843/vector/abstract-smooth-strips-background.jpg?s=612x612&w=0&k=20&c=R66IL-5SmzWNoKqMTpYEyozEqyOhpttqml_C6Ta6eEw=',
          isActive: true,
          order: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    } catch (e) {
      print('Error loading banners: $e');
    }
  }

  // Load new arrivals
  Future<void> loadNewArrivals() async {
    try {
      // Mock data for now
      newArrivals.value = [
        BSpokProduct(
          id: '1',
          name: 'Premium Suit Fabric',
          code: 'IDSH-0212',
          description: 'High-quality suit fabric',
          price: 340.0,
          categoryId: '1',
          categoryName: 'SUITING',
          images: ['https://images.unsplash.com/photo-1512436991641-6745cdb1723f'],
          sizes: ['S', 'M', 'L', 'XL'],
          colors: ['Black', 'Navy', 'Grey'],
          stockQuantity: 50,
          inStock: true,
          rating: 4.5,
          reviewCount: 12,
          isNewArrival: true,
          isFeatured: false,
          isOnSale: false,
          specifications: {'Material': 'Wool', 'Weight': '280g/m²'},
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        BSpokProduct(
          id: '2',
          name: 'Wool Blend Fabric',
          code: 'IDSH-0213',
          description: 'Premium wool blend fabric',
          price: 280.0,
          categoryId: '2',
          categoryName: 'WOOL',
          images: ['https://images.unsplash.com/photo-1465101046530-73398c7f28ca'],
          sizes: ['S', 'M', 'L', 'XL'],
          colors: ['Brown', 'Beige', 'Charcoal'],
          stockQuantity: 30,
          inStock: true,
          rating: 4.2,
          reviewCount: 8,
          isNewArrival: true,
          isFeatured: false,
          isOnSale: false,
          specifications: {'Material': 'Wool Blend', 'Weight': '250g/m²'},
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        BSpokProduct(
          id: '3',
          name: 'Classic Suit Material',
          code: 'IDSH-0214',
          description: 'Classic suit material',
          price: 420.0,
          categoryId: '1',
          categoryName: 'SUITING',
          images: ['https://images.unsplash.com/photo-1512436991641-6745cdb1723f'],
          sizes: ['S', 'M', 'L', 'XL'],
          colors: ['Navy', 'Black', 'Grey'],
          stockQuantity: 25,
          inStock: true,
          rating: 4.7,
          reviewCount: 15,
          isNewArrival: true,
          isFeatured: false,
          isOnSale: false,
          specifications: {'Material': 'Premium Wool', 'Weight': '300g/m²'},
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        BSpokProduct(
          id: '4',
          name: 'Lightweight Wool',
          code: 'IDSH-0215',
          description: 'Lightweight wool fabric',
          price: 320.0,
          categoryId: '2',
          categoryName: 'WOOL',
          images: ['https://images.unsplash.com/photo-1465101046530-73398c7f28ca'],
          sizes: ['S', 'M', 'L', 'XL'],
          colors: ['Cream', 'Light Grey', 'Beige'],
          stockQuantity: 40,
          inStock: true,
          rating: 4.3,
          reviewCount: 10,
          isNewArrival: true,
          isFeatured: false,
          isOnSale: false,
          specifications: {'Material': 'Light Wool', 'Weight': '200g/m²'},
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    } catch (e) {
      print('Error loading new arrivals: $e');
    }
  }

  // Load featured products
  Future<void> loadFeaturedProducts() async {
    try {
      // Mock data for now
      featuredProducts.value = newArrivals.take(2).toList();
    } catch (e) {
      print('Error loading featured products: $e');
    }
  }

  // Load products with filters
  Future<void> loadProducts() async {
    try {
      // Mock data for now
      products.value = newArrivals;
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  // Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  // Filter products based on search query
  void filterProducts() {
    if (searchQuery.value.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products.where((product) {
        return product.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
               product.description.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  // Search products
  Future<void> searchProducts(String query) async {
    try {
      searchQuery.value = query;
      if (query.isNotEmpty) {
        // Mock search
        final searchResults = newArrivals.where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()) ||
          product.code.toLowerCase().contains(query.toLowerCase())
        ).toList();
        products.value = searchResults;
      } else {
        await loadProducts();
      }
    } catch (e) {
      Get.snackbar('Error', 'Search failed: $e');
    }
  }

  // Filter by category
  Future<void> filterByCategory(String categoryId) async {
    try {
      selectedCategory.value = categoryId;
      final filteredProducts = newArrivals.where((product) =>
        product.categoryId == categoryId
      ).toList();
      products.value = filteredProducts;
    } catch (e) {
      Get.snackbar('Error', 'Filter failed: $e');
    }
  }

  // Sort products
  Future<void> sortProducts(String sortField, String order) async {
    try {
      sortBy.value = sortField;
      sortOrder.value = order;
      final sortedProducts = List<BSpokProduct>.from(products);
      
      if (sortField == 'name') {
        sortedProducts.sort((a, b) => order == 'asc' 
          ? a.name.compareTo(b.name) 
          : b.name.compareTo(a.name));
      } else if (sortField == 'price') {
        sortedProducts.sort((a, b) => order == 'asc' 
          ? a.price.compareTo(b.price) 
          : b.price.compareTo(a.price));
      }
      
      products.value = sortedProducts;
    } catch (e) {
      Get.snackbar('Error', 'Sort failed: $e');
    }
  }

  // Toggle price visibility
  void togglePriceVisibility() {
    isPriceVisible.value = !isPriceVisible.value;
    // Force UI update
    update();
  }

  // Clear filters
  Future<void> clearFilters() async {
    try {
      selectedCategory.value = '';
      searchQuery.value = '';
      sortBy.value = 'name';
      sortOrder.value = 'asc';
      await loadProducts();
    } catch (e) {
      Get.snackbar('Error', 'Failed to clear filters: $e');
    }
  }

  // Refresh data
  Future<void> refreshData() async {
    await loadHomeData();
  }

  // Get category by ID
  BSpokCategory? getCategoryById(String categoryId) {
    try {
      return categories.firstWhere((category) => category.id == categoryId);
    } catch (e) {
      return null;
    }
  }

  // Get product by ID
  BSpokProduct? getProductById(String productId) {
    try {
      return products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  // Navigate to product details
  void navigateToProduct(String productId) {
    Get.toNamed('/bspok/product/$productId');
  }

  // Navigate to category products
  void navigateToCategory(String categoryId) {
    filterByCategory(categoryId);
  }

  // Navigate to cart
  void navigateToCart() {
    Get.toNamed('/bspok/cart');
  }

  // Navigate to profile
  void navigateToProfile() {
    Get.toNamed('/bspok/profile');
  }

  // Navigate to orders
  void navigateToOrders() {
    Get.toNamed('/bspok/orders');
  }

  // Open camera scanner
  void openScanner() {
    Get.toNamed('/bspok/scanner');
  }

  // Show filter options
  void showFilterOptions() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Filter Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner, color: Colors.red),
              title: const Text('Scan QR Code'),
              subtitle: const Text('Scan product QR code'),
              onTap: () {
                Get.back();
                openScanner();
              },
            ),
            ListTile(
              leading: const Icon(Icons.category, color: Colors.red),
              title: const Text('Filter by Category'),
              onTap: () {
                Get.back();
                showCategoryFilter();
              },
            ),
            ListTile(
              leading: const Icon(Icons.sort, color: Colors.red),
              title: const Text('Sort Products'),
              onTap: () {
                Get.back();
                showSortOptions();
              },
            ),
            ListTile(
              leading: const Icon(Icons.clear, color: Colors.red),
              title: const Text('Clear Filters'),
              onTap: () {
                Get.back();
                clearFilters();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Show category filter
  void showCategoryFilter() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(category.imageUrl),
                    ),
                    title: Text(category.name),
                    subtitle: Text('${category.productCount} products'),
                    onTap: () {
                      Get.back();
                      filterByCategory(category.id);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Show sort options
  void showSortOptions() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Sort Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.sort_by_alpha, color: Colors.red),
              title: const Text('Name A-Z'),
              onTap: () {
                Get.back();
                sortProducts('name', 'asc');
              },
            ),
            ListTile(
              leading: const Icon(Icons.sort_by_alpha, color: Colors.red),
              title: const Text('Name Z-A'),
              onTap: () {
                Get.back();
                sortProducts('name', 'desc');
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money, color: Colors.red),
              title: const Text('Price Low to High'),
              onTap: () {
                Get.back();
                sortProducts('price', 'asc');
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money, color: Colors.red),
              title: const Text('Price High to Low'),
              onTap: () {
                Get.back();
                sortProducts('price', 'desc');
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
} 