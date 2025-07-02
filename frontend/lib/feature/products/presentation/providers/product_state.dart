import 'package:frontend/feature/products/domain/entities/product_entity.dart';

enum ProductStatus { initial, loading, success, error }

class ProductState {
  final ProductStatus status;
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final String? errorMessage;
  final String searchQuery;
  final bool isAddingProduct;
  final bool isUpdatingProduct;
  final bool isDeletingProduct;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.filteredProducts = const [],
    this.errorMessage,
    this.searchQuery = '',
    this.isAddingProduct = false,
    this.isUpdatingProduct = false,
    this.isDeletingProduct = false,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? products,
    List<ProductEntity>? filteredProducts,
    String? errorMessage,
    String? searchQuery,
    bool? isAddingProduct,
    bool? isUpdatingProduct,
    bool? isDeletingProduct,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      isAddingProduct: isAddingProduct ?? this.isAddingProduct,
      isUpdatingProduct: isUpdatingProduct ?? this.isUpdatingProduct,
      isDeletingProduct: isDeletingProduct ?? this.isDeletingProduct,
    );
  }
}
