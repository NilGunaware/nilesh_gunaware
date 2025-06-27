class BSpokOrder {
  final String id;
  final String userId;
  final List<BSpokOrderItem> items;
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
              ?.map((item) => BSpokOrderItem.fromJson(item))
              .toList() ??
          [],
      subtotal: (json['subtotal'] ?? 0.0).toDouble(),
      tax: (json['tax'] ?? 0.0).toDouble(),
      shipping: (json['shipping'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      status: json['status'] ?? 'pending',
      trackingNumber: json['tracking_number'],
      shippingAddress: json['shipping_address'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? 'pending',
      orderDate: DateTime.parse(json['order_date']),
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

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  BSpokOrder copyWith({
    String? id,
    String? userId,
    List<BSpokOrderItem>? items,
    double? subtotal,
    double? tax,
    double? shipping,
    double? total,
    String? status,
    String? trackingNumber,
    String? shippingAddress,
    String? paymentMethod,
    String? paymentStatus,
    DateTime? orderDate,
    DateTime? deliveryDate,
  }) {
    return BSpokOrder(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      shipping: shipping ?? this.shipping,
      total: total ?? this.total,
      status: status ?? this.status,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
    );
  }
}

class BSpokOrderItem {
  final String id;
  final String productId;
  final String productName;
  final String productCode;
  final String productImage;
  final double price;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;

  BSpokOrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  factory BSpokOrderItem.fromJson(Map<String, dynamic> json) {
    return BSpokOrderItem(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productCode: json['product_code'] ?? '',
      productImage: json['product_image'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
      selectedSize: json['selected_size'],
      selectedColor: json['selected_color'],
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
    };
  }

  double get totalPrice => price * quantity;
} 