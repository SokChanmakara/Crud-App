class ProductEntity {
  ProductEntity({
    required this.name,
    required this.price,
    required this.stock,
    this.imagePath,
  });

  final String name;
  final String? imagePath;
  final int price;
  final int stock;
}