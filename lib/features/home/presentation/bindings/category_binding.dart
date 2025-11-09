import 'package:e_commerce/features/home/data/datasources/category_remote_datasource.dart';
import 'package:e_commerce/features/home/data/repositories/category_repository_impl.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_category_usecase.dart';
import 'package:e_commerce/features/home/presentation/controllers/category_by_id_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/category_controller.dart';
import 'package:get/get.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    final dataSource = CategoryRemoteDataSource();
    final repository = CategoryRepositoryImpl(dataSource);
    final categoryUseCase = GetAllCategoryUseCase(repository);
    Get.lazyPut(() => CategoryController(categoryUseCase));

    Get.lazyPut(() => CategoryByIdController(Get.find()));
  }
}
