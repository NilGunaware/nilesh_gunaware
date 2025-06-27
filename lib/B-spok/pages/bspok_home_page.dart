import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bspok_home_controller.dart';
import '../controllers/bspok_cart_controller.dart';
import '../models/bspok_product_model.dart';
import '../models/bspok_category_model.dart';

class BSpokHomePage extends StatelessWidget {
  const BSpokHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(BSpokHomeController());
    final cartController = Get.find<BSpokCartController>();

    return Scaffold(
      drawer: _buildDrawer(homeController),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: homeController.refreshData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Carousel
                _buildBannerCarousel(homeController),
                const SizedBox(height: 18),
                
                // Shop by Category Title
                _SectionTitle(title: 'SHOP BY CATEGORY'),

                // Shop by Category Cards
                _buildCategorySection(homeController),
                const SizedBox(height: 18),
                
                // New Arrivals Title
                _SectionTitle(title: 'NEW ARRIVALS'),
                const SizedBox(height: 18),
                
                // Filter/Category/Sort Chips
                _buildFilterChips(homeController),
                
                // Product Grid
                _buildProductGrid(homeController, cartController),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDrawer(BSpokHomeController controller) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35, color: Colors.red),
                ),
                const SizedBox(height: 10),
                const Text(
                  'B-SPOK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Fashion E-commerce',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.red),
            title: const Text('Home'),
            onTap: () {
              Get.back();
              Get.offAllNamed('/bspok/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.category, color: Colors.red),
            title: const Text('Categories'),
            onTap: () {
              Get.back();
              controller.showCategoryFilter();
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.red),
            title: const Text('Cart'),
            onTap: () {
              Get.back();
              controller.navigateToCart();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.red),
            title: const Text('Profile'),
            onTap: () {
              Get.back();
              controller.navigateToProfile();
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long, color: Colors.red),
            title: const Text('Orders'),
            onTap: () {
              Get.back();
              controller.navigateToOrders();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.red),
            title: const Text('Settings'),
            onTap: () {
              Get.back();
              // Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.red),
            title: const Text('Help & Support'),
            onTap: () {
              Get.back();
              // Navigate to help
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel(BSpokHomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 420,
            child: PageView.builder(
              itemCount: controller.banners.length,
              itemBuilder: (context, index) {
                final banner = controller.banners[index];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(banner.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                              builder: (context) => IconButton(
                                icon: const Icon(Icons.menu, color: Colors.white),
                                onPressed: () => Scaffold.of(context).openDrawer(),
                              ),
                            ),
                            Text(
                              banner.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                                  onPressed: () => controller.navigateToCart(),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                                  onPressed: controller.navigateToProfile,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.lock_clock_rounded, color: Colors.white),
                                  onPressed: controller.navigateToOrders,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.white30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("show price", style: TextStyle(color: Colors.white)),
                            GetBuilder<BSpokHomeController>(
                              builder: (controller) => Switch(
                                value: controller.isPriceVisible.value,
                                onChanged: (val) => controller.togglePriceVisibility(),
                                activeColor: Colors.red,
                              ),
                            ),
                            SizedBox(width: 50),
                            Text("hide price", style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Search here...',
                                    hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                                    prefixIcon: Icon(Icons.search, size: 20, color: Colors.white),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  ),
                                  onChanged: controller.updateSearchQuery,
                                  onSubmitted: controller.searchProducts,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.tune, color: Colors.white, size: 20),
                                onPressed: () => controller.showFilterOptions(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Dot Indicators
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(controller.banners.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.white : Colors.white.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BSpokHomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: controller.categories.take(2).map((category) {
          return _CategoryCard(
            imageUrl: category.imageUrl,
            label: category.name,
            onTap: () => controller.navigateToCategory(category.id),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterChips(BSpokHomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FilterChip(
            label: 'FILTER', 
            icon: Icons.filter_list,
            onTap: () => controller.showFilterOptions(),
          ),
          _FilterChip(
            label: 'CATEGORY', 
            icon: Icons.category,
            onTap: () => controller.showCategoryFilter(),
          ),
          _FilterChip(
            label: 'SORT', 
            icon: Icons.sort,
            onTap: () => controller.showSortOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BSpokHomeController homeController, BSpokCartController cartController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: GetBuilder<BSpokHomeController>(
        builder: (controller) => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.67,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: controller.newArrivals.length,
          itemBuilder: (context, index) {
            final product = controller.newArrivals[index];
            return _ProductCard(
              product: product,
              onAddToCart: () => cartController.addToCart(product),
              onTap: () => controller.navigateToProduct(product.id),
              isPriceVisible: controller.isPriceVisible.value,
            );
          },
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Divider(thickness: 1, color: Colors.grey[300]),
          ),
          const SizedBox(width: 6),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 1),
          ),
          const SizedBox(width: 6),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Divider(thickness: 1, color: Colors.grey[300]),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  
  const _FilterChip({required this.label, required this.icon, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        foregroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.imageUrl, 
    required this.label, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, width: 90, height: 90, fit: BoxFit.cover),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final BSpokProduct product;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;
  final bool isPriceVisible;

  const _ProductCard({
    required this.product,
    required this.onAddToCart,
    required this.onTap,
    required this.isPriceVisible,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.red, width: 1),
        ),
        elevation: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product.images.isNotEmpty ? product.images.first : 'https://via.placeholder.com/150',
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.code,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 2),

                  if (isPriceVisible)
                    Text(
                      '₹ ${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle, 
                        color: product.inStock ? Colors.green : Colors.red, 
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.inStock ? 'In stock' : 'Out of stock',
                        style: TextStyle(
                          fontSize: 11, 
                          color: product.inStock ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      ),
                      onPressed: product.inStock ? onAddToCart : null,
                      icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                      label: const Text('Add to cart', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
