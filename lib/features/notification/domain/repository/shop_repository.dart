import 'package:e_commerce/features/notification/data/datasource/shop_remote_datasource.dart';
import 'package:e_commerce/features/notification/data/model/shop_model.dart';

abstract class ShopRepository {
  Future<List<ShopModel>> fetchProductShop();
}

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDatasource remoteDatasource;
  ShopRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<ShopModel>> fetchProductShop() async {
    return await remoteDatasource.fetchProductShop();
  }
}
