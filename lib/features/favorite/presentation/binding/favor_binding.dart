import 'package:e_commerce/features/favorite/data/datasource/favor_remote_datasource.dart';
import 'package:e_commerce/features/favorite/domain/repository/favor_repository.dart';
import 'package:e_commerce/features/favorite/domain/usecase/favor_request_usecase.dart';
import 'package:e_commerce/features/favorite/domain/usecase/favor_usecase.dart';
import 'package:e_commerce/features/favorite/presentation/controller/favor_controller.dart';
import 'package:get/get.dart';

class FavorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavorRemoteDatasource>(() => FavorRemoteDatasourceImpl());
    Get.lazyPut<FavorRepository>(() => FavorRepositoryImpl(Get.find()));
    Get.lazyPut(() => FavorUseCase(Get.find()));
    Get.lazyPut(() => FavorController(Get.find(), Get.find()));

    Get.lazyPut(() => toggleFavorUseCase(Get.find()));
  }
}
