import 'package:frontend/core/errors/failures.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getProducts();
  }
}
