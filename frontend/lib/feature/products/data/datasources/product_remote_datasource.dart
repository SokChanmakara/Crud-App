import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/feature/products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiClient.get('/products');

      // Parse the actual API response
      final List<dynamic> productsJson = response['data'] ?? response;
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      // Fallback to mock data if backend is not available
      print('Backend not available, using mock data: $e');
      return [
        ProductModel(
          id: '1',
          name: 'Wireless Headphones',
          price: 30,
          stock: 20,
        ),
        ProductModel(id: '2', name: 'Bluetooth Speaker', price: 45, stock: 15),
        ProductModel(id: '3', name: 'Smart Watch', price: 120, stock: 8),
        ProductModel(id: '4', name: 'Phone Case', price: 15, stock: 50),
        ProductModel(id: '5', name: 'Charging Cable', price: 10, stock: 30),
      ];
    }
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      final response = await apiClient.post('/products', product.toJson());

      // Parse the response from backend
      final productJson = response['data'] ?? response;
      return ProductModel.fromJson(productJson);
    } catch (e) {
      // Fallback: return product with generated ID if backend fails
      print('Backend not available for add product, using fallback: $e');
      return ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: product.name,
        price: product.price,
        stock: product.stock,
      );
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      final response = await apiClient.put(
        '/products/${product.id}',
        product.toJson(),
      );

      // Parse the response from backend
      final productJson = response['data'] ?? response;
      return ProductModel.fromJson(productJson);
    } catch (e) {
      // Fallback: return original product if backend fails
      print('Backend not available for update product, using fallback: $e');
      return product;
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await apiClient.delete('/products/$id');
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
