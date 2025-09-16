import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/usecases/get_product_by_shop_usecase.dart';
import 'package:get/get.dart';

class ProductByShopController extends GetxController {
  final GetProductByShopUseCase usecase;

  ProductByShopController(this.usecase);

  final RxList<ProductModel> shops = <ProductModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    loadProductByShop(Get.arguments['userCode'].toString());
    super.onInit();
  }

  Future<void> loadProductByShop(String userCode) async {
    try {
      isLoading.value = true;
      final result = await usecase.call(userCode);
      shops.assignAll(result);
    } catch (e) {
      Get.snackbar('Fail to load Product Shop', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
