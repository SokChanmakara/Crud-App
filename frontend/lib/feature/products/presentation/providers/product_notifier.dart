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

  ProductNotifier({
    required this.getProductsUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  }) : super(const ProductState());

  Future<void> loadProducts() async {
    state = state.copyWith(status: ProductStatus.loading);

    final result = await getProductsUseCase();

    result.fold(
      (failure) =>
          state = state.copyWith(
            status: ProductStatus.error,
            errorMessage: failure.message,
          ),
      (products) =>
          state = state.copyWith(
            status: ProductStatus.success,
            products: products,
            errorMessage: null,
          ),
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
        state = state.copyWith(
          products: updatedProducts,
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
        state = state.copyWith(
          products: updatedProducts,
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
        state = state.copyWith(
          products: updatedProducts,
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
}
