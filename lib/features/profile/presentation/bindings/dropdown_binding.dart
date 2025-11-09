import 'package:e_commerce/features/profile/data/datasources/add_product_remote_datasource.dart';
import 'package:e_commerce/features/profile/data/datasources/dropdown_remote_datasource.dart';
import 'package:e_commerce/features/profile/domain/repositories/add_product_repository.dart';
import 'package:e_commerce/features/profile/domain/repositories/dropdown_repository.dart';
import 'package:e_commerce/features/profile/domain/usecases/add_product_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/dropdown_usecase.dart';
import 'package:e_commerce/features/profile/presentation/controller/add_product_controller.dart';
import 'package:get/get.dart';

class DropdownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DropdownRemoteDatasource>(() => DropdownRemoteDatasourceImpl());
    Get.lazyPut<DropdownRepository>(() => DropdownRepositoryImpl(Get.find()));
    Get.lazyPut(() => DropdownUseCase(Get.find()));

    Get.lazyPut<AddProductRemoteDatasource>(
        () => AddProductRemoteDatasourceImpl());
    Get.lazyPut<AddProductRepository>(
        () => AddProductRepositoryImpl(Get.find()));

    Get.lazyPut(() => AddProductUseCase(Get.find()));

    Get.lazyPut(() => DropdownController(Get.find(), Get.find()));
  }
}
