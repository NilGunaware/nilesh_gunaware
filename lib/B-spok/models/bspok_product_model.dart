class BSpokProduct {
  final String id;
  final String name;
  final String code;
  final String description;
  final double price;
  final double? originalPrice;
  final String categoryId;
  final String categoryName;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;
  final int stockQuantity;
  final bool inStock;
  final double rating;
  final int reviewCount;
  final bool isNewArrival;
  final bool isFeatured;
  final bool isOnSale;
  final double? discountPercentage;
  final Map<String, dynamic> specifications;
  final DateTime createdAt;
  final DateTime updatedAt;

  BSpokProduct({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.categoryId,
    required this.categoryName,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.stockQuantity,
    required this.inStock,
    required this.rating,
    required this.reviewCount,
    required this.isNewArrival,
    required this.isFeatured,
    required this.isOnSale,
    this.discountPercentage,
    required this.specifications,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BSpokProduct.fromJson(Map<String, dynamic> json) {
    return BSpokProduct(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      originalPrice: json['original_price'] != null 
          ? (json['original_price'] as num).toDouble() 
          : null,
      categoryId: json['category_id'] ?? '',
      categoryName: json['category_name'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      sizes: List<String>.from(json['sizes'] ?? []),
      colors: List<String>.from(json['colors'] ?? []),
      stockQuantity: json['stock_quantity'] ?? 0,
      inStock: json['in_stock'] ?? false,
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      isNewArrival: json['is_new_arrival'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      isOnSale: json['is_on_sale'] ?? false,
      discountPercentage: json['discount_percentage'] != null 
          ? (json['discount_percentage'] as num).toDouble() 
          : null,
      specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'price': price,
      'original_price': originalPrice,
      'category_id': categoryId,
      'category_name': categoryName,
      'images': images,
      'sizes': sizes,
      'colors': colors,
      'stock_quantity': stockQuantity,
      'in_stock': inStock,
      'rating': rating,
      'review_count': reviewCount,
      'is_new_arrival': isNewArrival,
      'is_featured': isFeatured,
      'is_on_sale': isOnSale,
      'discount_percentage': discountPercentage,
      'specifications': specifications,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  BSpokProduct copyWith({
    String? id,
    String? name,
    String? code,
    String? description,
    double? price,
    double? originalPrice,
    String? categoryId,
    String? categoryName,
    List<String>? images,
    List<String>? sizes,
    List<String>? colors,
    int? stockQuantity,
    bool? inStock,
    double? rating,
    int? reviewCount,
    bool? isNewArrival,
    bool? isFeatured,
    bool? isOnSale,
    double? discountPercentage,
    Map<String, dynamic>? specifications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BSpokProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      inStock: inStock ?? this.inStock,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isNewArrival: isNewArrival ?? this.isNewArrival,
      isFeatured: isFeatured ?? this.isFeatured,
      isOnSale: isOnSale ?? this.isOnSale,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      specifications: specifications ?? this.specifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 