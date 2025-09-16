import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/datasources/category_remote_datasource.dart';
import 'package:e_commerce/features/home/data/datasources/product_remote_datasource.dart';
import 'package:e_commerce/features/home/data/repositories/category_repository_impl.dart';
import 'package:e_commerce/features/home/data/repositories/product_repository_impl.dart';
import 'package:e_commerce/features/home/domain/repositories/product_repository.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_category_usecase.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:e_commerce/features/home/presentation/controllers/category_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    DioConfig dio = DioConfig();

    Get.lazyPut(() => ProductRemoteDataSource(dio));
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetAllProductUseCase(Get.find()));
    Get.lazyPut(() => ProductController(Get.find()));

    Get.lazyPut(() => CategoryRemoteDataSource(dio));
    Get.lazyPut(() => CategoryRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetAllCategoryUseCase(Get.find()));
    Get.lazyPut(() => CategoryController(Get.find()));
  }
}
