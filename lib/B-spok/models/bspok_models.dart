class BSpokUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final String? address;
  final DateTime createdAt;
  final bool isActive;

  BSpokUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.address,
    required this.createdAt,
    this.isActive = true,
  });

  factory BSpokUser.fromJson(Map<String, dynamic> json) {
    return BSpokUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: json['profile_image'],
      address: json['address'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'address': address,
      'created_at': createdAt.toIso8601String(),
      'is_active': isActive,
    };
  }
}

class BSpokCategory {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final bool isActive;
  final int productCount;

  BSpokCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    this.isActive = true,
    this.productCount = 0,
  });

  factory BSpokCategory.fromJson(Map<String, dynamic> json) {
    return BSpokCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
      isActive: json['is_active'] ?? true,
      productCount: json['product_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'description': description,
      'is_active': isActive,
      'product_count': productCount,
    };
  }
}

class BSpokProduct {
  final String id;
  final String name;
  final String code;
  final String categoryId;
  final String categoryName;
  final String imageUrl;
  final List<String> additionalImages;
  final double price;
  final double? originalPrice;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final int stockQuantity;
  final bool isInStock;
  final bool isNewArrival;
  final bool isFeatured;
  final double rating;
  final int reviewCount;
  final Map<String, dynamic> specifications;
  final DateTime createdAt;

  BSpokProduct({
    required this.id,
    required this.name,
    required this.code,
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
    this.additionalImages = const [],
    required this.price,
    this.originalPrice,
    required this.description,
    this.sizes = const [],
    this.colors = const [],
    required this.stockQuantity,
    this.isInStock = true,
    this.isNewArrival = false,
    this.isFeatured = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.specifications = const {},
    required this.createdAt,
  });

  factory BSpokProduct.fromJson(Map<String, dynamic> json) {
    return BSpokProduct(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      categoryId: json['category_id'] ?? '',
      categoryName: json['category_name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      additionalImages: List<String>.from(json['additional_images'] ?? []),
      price: (json['price'] ?? 0.0).toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      description: json['description'] ?? '',
      sizes: List<String>.from(json['sizes'] ?? []),
      colors: List<String>.from(json['colors'] ?? []),
      stockQuantity: json['stock_quantity'] ?? 0,
      isInStock: json['is_in_stock'] ?? true,
      isNewArrival: json['is_new_arrival'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'category_id': categoryId,
      'category_name': categoryName,
      'image_url': imageUrl,
      'additional_images': additionalImages,
      'price': price,
      'original_price': originalPrice,
      'description': description,
      'sizes': sizes,
      'colors': colors,
      'stock_quantity': stockQuantity,
      'is_in_stock': isInStock,
      'is_new_arrival': isNewArrival,
      'is_featured': isFeatured,
      'rating': rating,
      'review_count': reviewCount,
      'specifications': specifications,
      'created_at': createdAt.toIso8601String(),
    };
  }

  double get discountPercentage {
    if (originalPrice == null || originalPrice == 0) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }
}

class BSpokCartItem {
  final String id;
  final String productId;
  final String productName;
  final String productCode;
  final String imageUrl;
  final double price;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final int maxQuantity;

  BSpokCartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
    required this.maxQuantity,
  });

  factory BSpokCartItem.fromJson(Map<String, dynamic> json) {
    return BSpokCartItem(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productCode: json['product_code'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
      selectedSize: json['selected_size'],
      selectedColor: json['selected_color'],
      maxQuantity: json['max_quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_code': productCode,
      'image_url': imageUrl,
      'price': price,
      'quantity': quantity,
      'selected_size': selectedSize,
      'selected_color': selectedColor,
      'max_quantity': maxQuantity,
    };
  }

  double get totalPrice => price * quantity;

  BSpokCartItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productCode,
    String? imageUrl,
    double? price,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    int? maxQuantity,
  }) {
    return BSpokCartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      maxQuantity: maxQuantity ?? this.maxQuantity,
    );
  }
}

class BSpokOrder {
  final String id;
  final String userId;
  final List<BSpokCartItem> items;
  final double subtotal;
  final double tax;
  final double shipping;
  final double total;
  final String status;
  final String? trackingNumber;
  final String shippingAddress;
  final String paymentMethod;
  final String paymentStatus;
  final DateTime orderDate;
  final DateTime? deliveryDate;

  BSpokOrder({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.shipping,
    required this.total,
    required this.status,
    this.trackingNumber,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderDate,
    this.deliveryDate,
  });

  factory BSpokOrder.fromJson(Map<String, dynamic> json) {
    return BSpokOrder(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => BSpokCartItem.fromJson(item))
              .toList() ??
          [],
      subtotal: (json['subtotal'] ?? 0.0).toDouble(),
      tax: (json['tax'] ?? 0.0).toDouble(),
      shipping: (json['shipping'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      status: json['status'] ?? '',
      trackingNumber: json['tracking_number'],
      shippingAddress: json['shipping_address'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      orderDate: DateTime.parse(json['order_date'] ?? DateTime.now().toIso8601String()),
      deliveryDate: json['delivery_date'] != null
          ? DateTime.parse(json['delivery_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'tax': tax,
      'shipping': shipping,
      'total': total,
      'status': status,
      'tracking_number': trackingNumber,
      'shipping_address': shippingAddress,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'order_date': orderDate.toIso8601String(),
      'delivery_date': deliveryDate?.toIso8601String(),
    };
  }
}

class BSpokBanner {
  final String id;
  final String title;
  final String imageUrl;
  final String? linkUrl;
  final bool isActive;
  final int order;

  BSpokBanner({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.linkUrl,
    this.isActive = true,
    this.order = 0,
  });

  factory BSpokBanner.fromJson(Map<String, dynamic> json) {
    return BSpokBanner(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
      linkUrl: json['link_url'],
      isActive: json['is_active'] ?? true,
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'link_url': linkUrl,
      'is_active': isActive,
      'order': order,
    };
  }
} 