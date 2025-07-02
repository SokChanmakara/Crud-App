class ProductEntity {
  ProductEntity({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
  });

  final String? id;
  final String name;
  final int price;
  final int stock;

  ProductEntity copyWith({
    String? id, 
    String? name,
    int? price,
    int? stock,
  }){
    return ProductEntity(
      id: id ?? this.id, 
      name: name ?? this.name, 
      price: price ?? this.price, 
      stock: stock ?? this.stock);
  }
}