import 'package:frontend/feature/products/domain/entities/product_entity.dart';

enum ProductStatus { initial, loading, success, error }

class ProductState {
  final ProductStatus status;
  final List<ProductEntity> products;
  final String? errorMessage;
  final bool isAddingProduct;
  final bool isUpdatingProduct;
  final bool isDeletingProduct;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.isAddingProduct = false,
    this.isUpdatingProduct = false,
    this.isDeletingProduct = false,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? products,
    String? errorMessage,
    bool? isAddingProduct,
    bool? isUpdatingProduct,
    bool? isDeletingProduct,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage,
      isAddingProduct: isAddingProduct ?? this.isAddingProduct,
      isUpdatingProduct: isUpdatingProduct ?? this.isUpdatingProduct,
      isDeletingProduct: isDeletingProduct ?? this.isDeletingProduct,
    );
  }
}
