import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/usecases/get_product_by_shop_usecase.dart';
import 'package:get/get.dart';

class ProductByShopController extends GetxController {
  final GetProductByShopDetailUseCase usecase;

  ProductByShopController(this.usecase);

  final RxList<ProductModel> shops = <ProductModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProductByShop(Get.arguments['shopId']);
  }

  Future<void> loadProductByShop(int id) async {
    try {
      isLoading(true);
      final result = await usecase(id);
      shops.assignAll(result);
    } catch (e) {
      // Get.snackbar('Fail to load Product Shop', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
