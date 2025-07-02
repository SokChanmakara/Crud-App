import 'package:frontend/core/errors/failures.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase({required this.repository});

  Future<Either<Failure, ProductEntity>> call(ProductEntity product) async {
    return await repository.updateProduct(product);
  }
}
