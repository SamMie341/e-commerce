import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/home/domain/repositories/product_repository.dart';

class GetAllProductUseCase {
  final Repository repository;

  GetAllProductUseCase(this.repository);

  Future<List<ProductModel>> call() {
    return repository.fetchAll();
  }
}
