import 'package:e_commerce/features/notification/data/model/shop_model.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';

class GetProductByShopUseCase {
  final ShopRepository repository;

  GetProductByShopUseCase(this.repository);

  Future<List<ShopModel>> call() async {
    return await repository.fetchProductShop();
  }
}
