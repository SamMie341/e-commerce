import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';

class GetProductByShopDetailUseCase {
  final ProductRepository repository;
  GetProductByShopDetailUseCase(this.repository);

  Future<List<ProductModel>> call(int id) {
    return repository.getProductByShop(id);
  }
}
