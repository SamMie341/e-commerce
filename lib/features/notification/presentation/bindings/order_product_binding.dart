import 'package:e_commerce/features/notification/data/datasource/order_product_remote.dart';
import 'package:e_commerce/features/notification/domain/repository/order_product_repository.dart';
import 'package:e_commerce/features/notification/domain/usecase/accept_order_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_accept_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_order_product_usecase.dart';
import 'package:e_commerce/features/notification/presentation/controller/order_product_controller.dart';
import 'package:get/get.dart';

class OrderProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderProductRemote>(() => OrderProductRemoteImpl());
    Get.lazyPut<OrderProductRepository>(
        () => OrderProductRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetOrderProductUseCase(Get.find()));

    //---------------------*-*--------------------------\\

    Get.lazyPut(() => GetAcceptProductUseCase(Get.find()));

    //---------------------*-*--------------------------\\

    Get.lazyPut(() => AcceptOrderProductUseCase(Get.find()));

    //---------------------*-*--------------------------\\
    Get.lazyPut(() => OrderProductController(
          Get.find(),
          Get.find(),
          Get.find(),
        ));
  }
}
