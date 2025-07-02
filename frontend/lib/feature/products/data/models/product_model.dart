import 'package:frontend/feature/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.id,
    required super.name,
    required super.price,
    required super.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['PRODUCTID']?.toString() ?? json['id']?.toString(),
      name: json['PRODUCTNAME'] ?? json['name'] ?? '',
      price:
          (json['PRICE'] is double)
              ? json['PRICE'].toInt()
              : (json['PRICE']?.toInt() ?? json['price']?.toInt() ?? 0),
      stock: json['STOCK']?.toInt() ?? json['stock']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'PRODUCTID': id,
      'productName': name, // Backend expects productName
      'price': price, // Backend expects price
      'stock': stock, // Backend expects stock
    };
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      stock: entity.stock,
    );
  }
}
