class ProductEntity {
  ProductEntity({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.stock,
  });

  final String name;
  final String imagePath;
  final int price;
  final int stock;
}