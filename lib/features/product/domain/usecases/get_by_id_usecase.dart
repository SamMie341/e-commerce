import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';

class GetByIdUseCase {
  final ProductRepository repository;

  GetByIdUseCase(this.repository);

  Future<ProductModel> call(int id) {
    return repository.getProductById(id);
  }
}
