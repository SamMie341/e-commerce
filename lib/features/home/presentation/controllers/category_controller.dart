import 'package:e_commerce/features/home/domain/entities/categorys_entity.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_category_usecase.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final GetAllCategoryUseCase getAllCategoryUseCase;

  CategoryController(this.getAllCategoryUseCase);

  final categoryList = <Category>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }

  Future<void> fetchCategory() async {
    try {
      isLoading.value = true;
      final category = await getAllCategoryUseCase();
      categoryList.assignAll(category);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
