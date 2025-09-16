import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/product/data/datasource/product_by_id_remote.dart';
import 'package:e_commerce/features/product/data/datasource/product_by_shop_remote.dart';
import 'package:e_commerce/features/product/data/datasource/review_remote_datasource.dart';
import 'package:e_commerce/features/product/data/repositories/product_by_id_repository_impl.dart';
import 'package:e_commerce/features/product/data/repositories/product_by_shop_repo_impl.dart';
import 'package:e_commerce/features/product/data/repositories/review_repository_impl.dart';
import 'package:e_commerce/features/product/domain/repositories/product_by_id_repository.dart';
import 'package:e_commerce/features/product/domain/repositories/product_by_shop_repo.dart';
import 'package:e_commerce/features/product/domain/repositories/review_repository.dart';
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
    DioConfig dioConfig = DioConfig();

    Get.lazyPut(() => ProductByIdRemote(dioConfig));
    Get.lazyPut<ProductByIdRepository>(
        () => ProductByIdRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetByIdUseCase(Get.find()));
    Get.lazyPut(() => ProductByIdController(Get.find()));

    Get.lazyPut(() => ReviewRemoteDatasource(dioConfig));
    Get.lazyPut<ReviewRepository>(() => ReviewRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetReviewUseCase(Get.find()));
    Get.lazyPut(() => ReviewController(Get.find()));

    Get.lazyPut(() => ProductByShopRemote(dioConfig));
    Get.lazyPut<ProductByShopRepo>(() => ProductByShopRepoImpl(Get.find()));
    Get.lazyPut(() => GetProductByShopUseCase(Get.find()));
    Get.lazyPut(() => ProductByShopController(Get.find()));
  }
}
