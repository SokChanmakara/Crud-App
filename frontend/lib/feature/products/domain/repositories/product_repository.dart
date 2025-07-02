import 'package:frontend/core/errors/failures.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, ProductEntity>> addProduct(ProductEntity product);
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);
  Future<Either<Failure, void>> deleteProduct(String id);
}

// Simple Either implementation (or use dartz package)
class Either<L, R> {
  final L? _left;
  final R? _right;

  Either.left(this._left) : _right = null;
  Either.right(this._right) : _left = null;

  bool get isLeft => _left != null;
  bool get isRight => _right != null;

  L get left => _left!;
  R get right => _right!;

  T fold<T>(T Function(L) leftFunc, T Function(R) rightFunc) {
    return isLeft ? leftFunc(_left!) : rightFunc(_right!);
  }
}
