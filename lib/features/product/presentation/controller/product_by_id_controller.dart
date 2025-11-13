import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/usecases/get_by_id_usecase.dart';
import 'package:get/get.dart';

class ProductByIdController extends GetxController {
  final GetByIdUseCase getByIdUseCase;

  ProductByIdController(this.getByIdUseCase);

  final isLoading = false.obs;

  Rxn<ProductModel> productDetail = Rxn<ProductModel>();

  @override
  void onInit() {
    loadProductById(Get.arguments['id']);
    super.onInit();
  }

  Future<void> loadProductById(int id) async {
    isLoading.value = true;
    try {
      final result = await getByIdUseCase(id);
      productDetail.value = result;
    } catch (e) {
      Get.snackbar('Fail to load product detail', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
