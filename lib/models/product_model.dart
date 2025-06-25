class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final int availableQty;
  final bool isNew;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.availableQty,
    this.isNew = false,
  });
} 