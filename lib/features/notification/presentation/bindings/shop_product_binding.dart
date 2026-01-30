import 'package:e_commerce/features/notification/data/datasource/shop_remote_datasource.dart';
import 'package:e_commerce/features/notification/domain/repository/shop_repository.dart';
import 'package:e_commerce/features/notification/domain/usecase/add_bank_qr_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/add_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/delete_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/delete_qr_bank_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_bank_qr_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_dropdown_bank_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_dropdown_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_product_by_shop_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/update_bank_qr_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/update_product_usecase.dart';
import 'package:e_commerce/features/notification/presentation/controller/shop_product_controller.dart';
import 'package:get/get.dart';

class ShopProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopRemoteDatasource>(() => ShopRemoteDatasourceImpl());
    Get.lazyPut<ShopRepository>(() => ShopRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetProductByShopUseCase(Get.find()));
    Get.lazyPut(() => GetDropdownUseCase(Get.find()));
    Get.lazyPut(() => UpdateProductUseCase(Get.find()));
    Get.lazyPut(() => GetBankQrUseCase(Get.find()));
    Get.lazyPut(() => GetDropdownBankUseCase(Get.find()));
    Get.lazyPut(() => AddBankQrUseCase(Get.find()));
    Get.lazyPut(() => UpdateBankQrUseCase(Get.find()));
    Get.lazyPut(() => DeleteQrBankUseCase(Get.find()));
    Get.lazyPut(() => AddProductUseCase(Get.find()));
    Get.lazyPut(() => DeleteProductUseCase(Get.find()));

    Get.lazyPut(() => ShopProductController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ));
  }
}
