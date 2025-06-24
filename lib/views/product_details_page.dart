import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../viewmodels/home_view_model.dart';

const kGold = Color(0xFFC9A063);
const kBrown = Color(0xFF5C4631);

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;
  final HomeViewModel controller = Get.find();

  // For image slider
  final RxInt _currentImageIndex = 0.obs;
  final PageController _pageController = PageController();

  ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = [product.imageUrl]; // ready for multiple images
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.lock_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Stack(
              children: [
                Container(
                  height: 300,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => _currentImageIndex.value = index,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(() => Text(
                          '${_currentImageIndex.value + 1}/${images.length}',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product ID: ${product.id}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5C4631),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFC9A063).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '100% cotton',
                          style: TextStyle(
                            color: Color(0xFFC9A063),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Available Quantity: 50',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  // Cart Controls
                  Obx(() {
                    final int qty = controller.getCartQuantity(product.id);
                    return Row(
                      children: [
                        if (qty == 0)
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kGold,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                elevation: 0,
                              ),
                              onPressed: () => controller.addToCart(product.id),
                              child: const Text('Add to cart', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ),
                          )
                        else ...[
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, size: 20, color: kGold),
                            onPressed: () => controller.removeFromCart(product.id),
                          ),
                          Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, color: kBrown)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, size: 20, color: kGold),
                            onPressed: () => controller.addToCart(product.id),
                          ),
                        ],
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Product Details Sections
            _buildExpandableSection('Product Details', 'High-quality fabric with detailed stitching...'),
            _buildExpandableSection('Material & Care', '100% Cotton\nMachine wash cold\nDo not bleach'),
            _buildExpandableSection('Specifications', 'Weight: 0.5 kg\nDimensions: 30 x 40 cm'),

            // Similar Products Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child:  Row(
                    children: [
                      const SizedBox(width: 16),
                      // Left double lines
                      Column(
                        children: [
                          Container(width: 70, height: 2, color: Colors.amber),
                          const SizedBox(height: 4),
                          Container(width: 70, height: 2, color: Colors.amber),
                        ],
                      ),
                      const SizedBox(width: 12),
                      // Text
                      Expanded(
                        child: Center(
                          child: Text(
                            "Similar Product",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Colors.brown[800],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Right double lines
                      Column(
                        children: [
                          Container(width: 70, height: 2, color: Colors.amber),
                          const SizedBox(height: 4),
                          Container(width: 70, height: 2, color: Colors.amber),
                        ],
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
                 _buildSimilarProducts(),
                SizedBox(height: 100), // Bottom padding for scroll
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title, String content) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5C4631),
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            content,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
  
  Widget _buildSimilarProducts() {
    return SizedBox(
      height: 304,
      child: Obx(() => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: controller.products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final ProductModel similarProduct = controller.products[index];
              if (similarProduct.id == product.id) return SizedBox.shrink();
              return SizedBox(
                width: 200,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          similarProduct.imageUrl,
                          height: 180,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${similarProduct.price}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kBrown,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Product ID: ${similarProduct.id}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Obx(() {
                              final int qty = controller.getCartQuantity(similarProduct.id);
                              return Row(
                                children: [
                                  if (qty == 0)
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          side: BorderSide(color: kBrown),
                                          backgroundColor: Colors.white,
                                          foregroundColor: kBrown,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          elevation: 0,
                                        ),
                                        onPressed: () => controller.addToCart(similarProduct.id),
                                        child: const Text('Add to cart', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                      ),
                                    )
                                  else ...[
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline, size: 20, color: kGold),
                                      onPressed: () => controller.removeFromCart(similarProduct.id),
                                    ),
                                    Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, color: kBrown)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline, size: 20, color: kGold),
                                      onPressed: () => controller.addToCart(similarProduct.id),
                                    ),
                                  ],
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}