import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/home_view_model.dart';
import '../models/product_model.dart';

const kGold = Color(0xFFC9A063);
const kBrown = Color(0xFF5C4631);

class CartPage extends StatelessWidget {
  final HomeViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kBrown),
          onPressed: () => Get.back(),
        ),
        title: const Text('Cart', style: TextStyle(color: kBrown, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        final cartItems = controller.cart.entries.toList();
        if (cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty', style: TextStyle(color: kBrown, fontSize: 18)));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cartItems.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final entry = cartItems[index];
            final product = controller.products.firstWhereOrNull((p) => p.id == entry.key);
            if (product == null) return const SizedBox();
            final qty = entry.value;
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(product.imageUrl, width: 56, height: 56, fit: BoxFit.cover),
              ),
              title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, color: kBrown)),
              subtitle: Text('₹ ${product.price.toStringAsFixed(0)}', style: const TextStyle(color: kBrown)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: kGold),
                    onPressed: () => controller.removeFromCart(product.id),
                  ),
                  Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, color: kBrown)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: kGold),
                    onPressed: () => controller.addToCart(product.id),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final cartItems = controller.cart.entries.toList();
        double total = 0;
        for (var entry in cartItems) {
          final product = controller.products.firstWhereOrNull((p) => p.id == entry.key);
          if (product != null) {
            total += product.price * entry.value;
          }
        }
        return cartItems.isEmpty
            ? const SizedBox.shrink()
            : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(0, -4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: ₹${total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: kBrown, fontSize: 16)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGold,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
      }),
    );
  }
} 