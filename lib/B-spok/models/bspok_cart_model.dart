class BSpokCartItem {
  final String id;
  final String productId;
  final String productName;
  final String productCode;
  final String productImage;
  final double price;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final bool inStock;

  BSpokCartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
    required this.inStock,
  });

  factory BSpokCartItem.fromJson(Map<String, dynamic> json) {
    return BSpokCartItem(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productCode: json['product_code'] ?? '',
      productImage: json['product_image'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
      selectedSize: json['selected_size'],
      selectedColor: json['selected_color'],
      inStock: json['in_stock'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_code': productCode,
      'product_image': productImage,
      'price': price,
      'quantity': quantity,
      'selected_size': selectedSize,
      'selected_color': selectedColor,
      'in_stock': inStock,
    };
  }

  double get totalPrice => price * quantity;

  BSpokCartItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productCode,
    String? productImage,
    double? price,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    bool? inStock,
  }) {
    return BSpokCartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      inStock: inStock ?? this.inStock,
    );
  }
}

class BSpokCart {
  final String id;
  final String userId;
  final List<BSpokCartItem> items;
  final double subtotal;
  final double tax;
  final double shipping;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;

  BSpokCart({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.shipping,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BSpokCart.fromJson(Map<String, dynamic> json) {
    return BSpokCart(
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  BSpokCart copyWith({
    String? id,
    String? userId,
    List<BSpokCartItem>? items,
    double? subtotal,
    double? tax,
    double? shipping,
    double? total,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BSpokCart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      shipping: shipping ?? this.shipping,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 