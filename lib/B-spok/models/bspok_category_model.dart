class BSpokCategory {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String? parentId;
  final int order;
  final bool isActive;
  final int productCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  BSpokCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.parentId,
    required this.order,
    required this.isActive,
    required this.productCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BSpokCategory.fromJson(Map<String, dynamic> json) {
    return BSpokCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      parentId: json['parent_id'],
      order: json['order'] ?? 0,
      isActive: json['is_active'] ?? true,
      productCount: json['product_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'parent_id': parentId,
      'order': order,
      'is_active': isActive,
      'product_count': productCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  BSpokCategory copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? parentId,
    int? order,
    bool? isActive,
    int? productCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BSpokCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      parentId: parentId ?? this.parentId,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      productCount: productCount ?? this.productCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 