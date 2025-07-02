import 'package:frontend/core/errors/failures.dart';
import 'package:frontend/feature/products/domain/repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase({required this.repository});

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteProduct(id);
  }
}
