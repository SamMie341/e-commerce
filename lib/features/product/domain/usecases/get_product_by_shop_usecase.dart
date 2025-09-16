import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_by_shop_repo.dart';

class GetProductByShopUseCase {
  final ProductByShopRepo repository;
  GetProductByShopUseCase(this.repository);

  Future<List<ProductModel>> call(String userCode) {
    return repository.getProductByShop(userCode);
  }
}
