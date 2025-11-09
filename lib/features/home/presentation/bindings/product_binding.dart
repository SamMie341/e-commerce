import 'package:e_commerce/features/home/data/datasources/remote_datasource.dart';
import 'package:e_commerce/features/home/domain/repositories/product_repository.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_categoryDetail_usecase.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:e_commerce/features/home/presentation/controllers/category_by_id_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDatasource>(() => RemoteDataSourceImpl());
    Get.lazyPut<Repository>(() => RepositoryImpl(Get.find()));
    Get.lazyPut(() => GetAllProductUseCase(Get.find()));
    Get.lazyPut(() => ProductController(Get.find()));

    Get.lazyPut(() => GetAllCategoryDetailUseCase(Get.find()));
    Get.lazyPut(() => CategoryByIdController(Get.find()));
  }
}
