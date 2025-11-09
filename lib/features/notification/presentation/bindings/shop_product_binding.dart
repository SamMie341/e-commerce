import 'package:e_commerce/features/notification/data/datasource/shop_remote_datasource.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_product_by_shop_usecase.dart';
import 'package:e_commerce/features/notification/presentation/controller/shop_product_controller.dart';
import 'package:get/get.dart';

class ShopProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopRemoteDatasource>(() => ShopRemoteDatasourceImpl());
    Get.lazyPut<ShopRepository>(() => ShopRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetProductByShopUseCase(Get.find()));
    Get.lazyPut(() => ShopProductController(Get.find()));
  }
}
