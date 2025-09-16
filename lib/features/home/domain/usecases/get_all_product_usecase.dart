import 'package:e_commerce/features/home/domain/entities/products_entity.dart';
import 'package:e_commerce/features/home/domain/repositories/product_repository.dart';

class GetAllProductUseCase {
  final ProductRepository repository;

  GetAllProductUseCase(this.repository);

  Future<List<Product>> call() {
    return repository.fetchAll();
  }
}
