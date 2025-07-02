import 'package:frontend/core/errors/failures.dart';
import 'package:frontend/feature/products/data/datasources/product_remote_datasource.dart';
import 'package:frontend/feature/products/data/models/product_model.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return Either.right(products);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> addProduct(
    ProductEntity product,
  ) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      final result = await remoteDataSource.addProduct(productModel);
      return Either.right(result);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    ProductEntity product,
  ) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      final result = await remoteDataSource.updateProduct(productModel);
      return Either.right(result);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      return Either.right(null);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }
}
