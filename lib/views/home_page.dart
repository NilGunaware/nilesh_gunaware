import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/home_view_model.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../views/product_details_page.dart';
import 'cart_page.dart';

const kGold = Color(0xFFC9A063);
const kBrown = Color(0xFF5C4631);

class HomePage extends StatelessWidget {
  final HomeViewModel controller = Get.put(HomeViewModel());

  final List<String> sortOptions = [
    'Default',
    'Price: Low to High',
    'Price: High to Low',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(),
            _buildSearchBar(),
            _sectionTitle('Quick action'),
            _buildQuickActions(),
            _sectionTitle('new arrivals'),
            _buildNewArrivalsHeader(),
            _buildProductGrid(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: kBrown, size: 22),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'ZUNYA',
        style: TextStyle(
          color: kBrown,
          fontWeight: FontWeight.w700,
          letterSpacing: 6,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      actions: [
        Obx(() {
          int cartCount = controller.cart.values.fold(0, (a, b) => a + b);
          return Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: kBrown, size: 22),
                onPressed: () => Get.to(() => CartPage()),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          );
        }),
        Obx(() => Switch(
          value: controller.isSwitched.value,
          onChanged: (val) => controller.isSwitched.value = val,
          activeColor: kGold,
        )),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: kGold),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(radius: 28, backgroundColor: Colors.white, child: Icon(Icons.person, size: 32, color: kGold)),
                SizedBox(height: 12),
                Text('Welcome!', style: TextStyle(color: kBrown, fontWeight: FontWeight.bold, fontSize: 18)),
                Text('ZUNYA User', style: TextStyle(color: kBrown)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: kBrown),
            title: const Text('Home'),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: kBrown),
            title: const Text('Cart'),
            onTap: () {
              Get.back();
              Get.to(() => CartPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: kBrown),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1512436991641-6745cdb1723f'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.black.withOpacity(0.18),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
           bottom: 30,
          child: Column(
            children: [
              const Text(
                'Innovate Without Inventory',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  elevation: 0,
                ),
                onPressed: () {},
                child: const Text('SHOP NOW', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: TextField(
                onChanged: controller.setSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Search Or Scan your QR here',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 13),
                  prefixIcon: const Icon(Icons.search, color: kBrown, size: 22),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: kGold,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.tune, color: Colors.white, size: 20),
              onPressed: () {
                // Optionally open a filter modal
                _showFilterBottomSheet(Get.context!);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sort By', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...sortOptions.map((option) => Obx(() => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: controller.sortOrder.value,
                    onChanged: (val) => controller.setSortOrder(val!),
                  ))),
              const Divider(),
              const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: controller.selectedCategory.value.isEmpty,
                    onSelected: (_) => controller.setCategory(''),
                  ),
                  ...controller.categories.map((cat) => Obx(() => ChoiceChip(
                        label: Text(cat.name),
                        selected: controller.selectedCategory.value == cat.name,
                        onSelected: (_) => controller.setCategory(cat.name),
                      ))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
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
                  title.toUpperCase(),
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
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 90,
          child: Obx(() => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final CategoryModel cat = controller.categories[index];
                  return Column(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(cat.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: kGold, width: 1),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat.name,
                        style: const TextStyle(fontSize: 12, color: kBrown, fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                },
              )),
        ),
      ],
    );

  }

  Widget _buildNewArrivalsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterItem('FILTER'),
          _buildFilterItem('CATEGORY'),
          _buildFilterItem('SORT'),
        ],
      ),
    );
  }

  Widget _buildFilterItem(String label) {
    final isSelected = label == 'SORT'
        ? controller.sortOrder.value.isNotEmpty
        : label == 'CATEGORY'
            ? controller.selectedCategory.value.isNotEmpty
            : false;

    final selectedText = label == 'SORT'
        ? controller.sortOrder.value
        : label == 'CATEGORY'
            ? controller.selectedCategory.value.isEmpty
                ? 'All'
                : controller.selectedCategory.value
            : label;

    return InkWell(
      onTap: () {
        if (label == 'SORT') {
          _showSortSheet();
        } else if (label == 'CATEGORY') {
          _showCategorySheet();
        }
        // Add more logic for 'FILTER' if needed
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                selectedText.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  color: kBrown,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 16, color: kBrown),
            ],
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 1.5,
              width: 40,
              color: kBrown,
            ),
        ],
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Default'),
              onTap: () {
                controller.setSortOrder('Default');
                Get.back();
              },
            ),
            ListTile(
              title: Text('Price: Low to High'),
              onTap: () {
                controller.setSortOrder('Price: Low to High');
                Get.back();
              },
            ),
            ListTile(
              title: Text('Price: High to Low'),
              onTap: () {
                controller.setSortOrder('Price: High to Low');
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCategorySheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('All'),
              onTap: () {
                controller.setCategory('');
                Get.back();
              },
            ),
            ...controller.categories.map((cat) => ListTile(
                  title: Text(cat.name),
                  onTap: () {
                    controller.setCategory(cat.name);
                    Get.back();
                  },
                )),
          ],
        );
      },
    );
  }

  Widget _buildProductGrid() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.58,
            ),
            itemCount: controller.filteredProducts.length,
            itemBuilder: (context, index) {
              final ProductModel product = controller.filteredProducts[index];
              return _buildProductCard(product);
            },
          ),
        ));
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsPage(product: product)),
      child: Card(
        elevation: 1.5,
        shadowColor: kGold.withOpacity(0.10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 2,
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: const Text('100% cotton', style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: kBrown),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Icon(Icons.lock,size: 17,color: kBrown,)
                ],
              ),
              const SizedBox(height: 4),
              Text("Avalable Qty : ${product.availableQty ?? 0}"),
              const SizedBox(height: 4),
              Text('₹ ${product.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, color: kBrown, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Obx(() {
                final int qty = controller.getCartQuantity(product.id);
                return Row(
                  children: [
                    if (qty == 0)
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: kBrown),
                             foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            elevation: 0,
                          ),
                          onPressed: () => controller.addToCart(product.id),
                          child: const Text('Add to cart', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: kBrown)),
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
      ),
    );
  }
}
