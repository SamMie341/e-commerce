import 'package:e_commerce/features/transaction/data/datasource/order_remote_datasource.dart';
import 'package:e_commerce/features/transaction/domain/repository/order_repository.dart';
import 'package:e_commerce/features/transaction/domain/usecase/delete_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_cancel_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_process_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_usecase.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRemoteDatasource>(() => OrderRemoteDataSourceImpl());
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl(Get.find()));
    Get.lazyPut(() => OrderUseCase(Get.find()));
    Get.lazyPut(() => OrderController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ));

//---------------------*--*--------------------\\

    Get.lazyPut(() => OrderProcessUseCase(Get.find()));

//---------------------*--*--------------------\\

    Get.lazyPut(() => OrderCancelUseCase(Get.find()));

//---------------------*--*--------------------\\

    Get.lazyPut(() => DeleteUseCase(Get.find()));
  }
}
