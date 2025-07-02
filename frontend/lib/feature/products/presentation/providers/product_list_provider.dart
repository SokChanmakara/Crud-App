import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/feature/products/data/datasources/product_remote_datasource.dart';
import 'package:frontend/feature/products/data/repositories/product_repository_impl.dart';
import 'package:frontend/feature/products/domain/repositories/product_repository.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/domain/usecases/get_products_usecase.dart';
import 'package:frontend/feature/products/domain/usecases/add_product_usecase.dart';
import 'package:frontend/feature/products/domain/usecases/update_product_usecase.dart';
import 'package:frontend/feature/products/domain/usecases/delete_product_usecase.dart';
import 'package:frontend/feature/products/presentation/providers/product_notifier.dart';
import 'package:frontend/feature/products/presentation/providers/product_state.dart';

// Dependencies
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  return ProductRemoteDataSourceImpl(apiClient: ref.read(apiClientProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    remoteDataSource: ref.read(productRemoteDataSourceProvider),
  );
});

// Use Cases
final getProductsUseCaseProvider = Provider<GetProductsUseCase>((ref) {
  return GetProductsUseCase(repository: ref.read(productRepositoryProvider));
});

final addProductUseCaseProvider = Provider<AddProductUseCase>((ref) {
  return AddProductUseCase(repository: ref.read(productRepositoryProvider));
});

final updateProductUseCaseProvider = Provider<UpdateProductUseCase>((ref) {
  return UpdateProductUseCase(repository: ref.read(productRepositoryProvider));
});

final deleteProductUseCaseProvider = Provider<DeleteProductUseCase>((ref) {
  return DeleteProductUseCase(repository: ref.read(productRepositoryProvider));
});

// Main Product Provider
final productListProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
      return ProductNotifier(
        getProductsUseCase: ref.read(getProductsUseCaseProvider),
        addProductUseCase: ref.read(addProductUseCaseProvider),
        updateProductUseCase: ref.read(updateProductUseCaseProvider),
        deleteProductUseCase: ref.read(deleteProductUseCaseProvider),
      );
    });

// Individual product provider (for getting specific product)
final productByIdProvider = Provider.family<ProductEntity?, String>((ref, id) {
  final products = ref.watch(productListProvider).products;
  return products.firstWhere(
    (product) => product.id == id,
    orElse: () => throw Exception('Product not found'),
  );
});
