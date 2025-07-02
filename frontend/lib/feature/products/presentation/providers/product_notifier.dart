import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/domain/usecases/get_products_usecase.dart';
import 'package:frontend/feature/products/domain/usecases/add_product_usecase.dart';
import 'package:frontend/feature/products/domain/usecases/update_product_usecase.dart';
import 'package:frontend/feature/products/domain/usecases/delete_product_usecase.dart';
import 'package:frontend/feature/products/presentation/providers/product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  Timer? _debounceTimer;

  ProductNotifier({
    required this.getProductsUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  }) : super(const ProductState());

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(status: ProductStatus.loading);

    final result = await getProductsUseCase();

    result.fold(
      (failure) =>
          state = state.copyWith(
            status: ProductStatus.error,
            errorMessage: failure.message,
          ),
      (products) {
        final filteredProducts = _filterProducts(products, state.searchQuery);
        state = state.copyWith(
          status: ProductStatus.success,
          products: products,
          filteredProducts: filteredProducts,
          errorMessage: null,
        );
      },
    );
  }

  Future<bool> addProduct(ProductEntity product) async {
    state = state.copyWith(isAddingProduct: true);

    final result = await addProductUseCase(product);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isAddingProduct: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (newProduct) {
        final updatedProducts = [...state.products, newProduct];
        final filteredProducts = _filterProducts(
          updatedProducts,
          state.searchQuery,
        );
        state = state.copyWith(
          products: updatedProducts,
          filteredProducts: filteredProducts,
          isAddingProduct: false,
          errorMessage: null,
        );
        return true;
      },
    );
  }

  Future<bool> updateProduct(ProductEntity product) async {
    state = state.copyWith(isUpdatingProduct: true);

    final result = await updateProductUseCase(product);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isUpdatingProduct: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (updatedProduct) {
        final updatedProducts =
            state.products.map((p) {
              return p.id == updatedProduct.id ? updatedProduct : p;
            }).toList();
        final filteredProducts = _filterProducts(
          updatedProducts,
          state.searchQuery,
        );
        state = state.copyWith(
          products: updatedProducts,
          filteredProducts: filteredProducts,
          isUpdatingProduct: false,
          errorMessage: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteProduct(String id) async {
    state = state.copyWith(isDeletingProduct: true);

    final result = await deleteProductUseCase(id);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isDeletingProduct: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        final updatedProducts =
            state.products.where((p) => p.id != id).toList();
        final filteredProducts = _filterProducts(
          updatedProducts,
          state.searchQuery,
        );
        state = state.copyWith(
          products: updatedProducts,
          filteredProducts: filteredProducts,
          isDeletingProduct: false,
          errorMessage: null,
        );
        return true;
      },
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void searchProducts(String query) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final filteredProducts = _filterProducts(state.products, query);
      state = state.copyWith(
        searchQuery: query,
        filteredProducts: filteredProducts,
      );
    });
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    state = state.copyWith(searchQuery: '', filteredProducts: state.products);
  }

  List<ProductEntity> _filterProducts(
    List<ProductEntity> products,
    String query,
  ) {
    if (query.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
