import 'package:e_commerce/features/payment/data/datasource/payment_datasource.dart';
import 'package:e_commerce/features/payment/domain/repository/payment_repository.dart';
import 'package:e_commerce/features/payment/domain/usecase/payment_usecase.dart';
import 'package:e_commerce/features/payment/presentation/controller/payment_controller.dart';
import 'package:get/get.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentRemoteDatasource>(() => PaymentRemoteDatasourceImpl());
    Get.lazyPut<PaymentRepository>(() => PaymentRepositoryImpl(Get.find()));
    Get.lazyPut(() => PaymentUseCase(Get.find()));
    Get.lazyPut(() => PaymentController(Get.find()));
  }
}
