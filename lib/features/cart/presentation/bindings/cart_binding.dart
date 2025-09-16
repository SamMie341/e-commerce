import 'package:e_commerce/features/cart/data/datasources/sale_remote_datasource.dart';
import 'package:e_commerce/features/cart/data/repositories/sale_repository.dart';
import 'package:e_commerce/features/cart/domain/usecase/sale_usecase.dart';
import 'package:e_commerce/features/cart/presentation/controllers/cart_controller.dart';
import 'package:e_commerce/features/cart/presentation/controllers/sale_controller.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());

    Get.lazyPut<SaleRemoteDatasource>(() => SaleRemoteDatasourceImpl());
    Get.lazyPut<SaleRepository>(() => SaleRepositoryImpl(Get.find()));
    Get.lazyPut(() => SaleUseCase(Get.find()));
    Get.lazyPut(() => SaleController(Get.find()));
  }
}
