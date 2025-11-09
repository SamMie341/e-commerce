import 'package:e_commerce/features/product/data/datasource/product_remote_datasource.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:e_commerce/features/product/domain/usecases/get_by_id_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/get_product_by_shop_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/get_review_usecase.dart';
import 'package:e_commerce/features/product/presentation/controller/product_by_id_controller.dart';
import 'package:e_commerce/features/product/presentation/controller/product_by_shop_controller.dart';
import 'package:e_commerce/features/product/presentation/controller/review_controller.dart';
import 'package:get/get.dart';

class ProductByIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRemoteDataSource>(() => ProductRemoteDatasourceImpl());
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(Get.find()));

    Get.lazyPut(() => GetByIdUseCase(Get.find()));
    Get.lazyPut(() => ProductByIdController(Get.find()));

    Get.lazyPut(() => GetReviewUseCase(Get.find()));
    Get.lazyPut(() => ReviewController(Get.find()));

    Get.lazyPut(() => GetProductByShopDetailUseCase(Get.find()));
    Get.lazyPut(() => ProductByShopController(Get.find()));
  }
}
