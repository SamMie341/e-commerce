import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/data/datasource/product_by_shop_remote.dart';
import 'package:e_commerce/features/product/domain/repositories/product_by_shop_repo.dart';

class ProductByShopRepoImpl implements ProductByShopRepo {
  final ProductByShopRemote remote;

  ProductByShopRepoImpl(this.remote);

  @override
  Future<List<ProductModel>> getProductByShop(String userCode) {
    return remote.fetchProductByShop(userCode);
  }
}
