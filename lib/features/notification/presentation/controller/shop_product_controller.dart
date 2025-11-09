import 'package:e_commerce/features/notification/data/model/shop_model.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_product_by_shop_usecase.dart';
import 'package:get/get.dart';

class ShopProductController extends GetxController {
  final GetProductByShopUseCase usecase;

  ShopProductController(this.usecase);

  final productList = <ShopModel>[].obs;

  final isLoading = false.obs;

  Stream<List<ShopModel>> fetchProduct() async* {
    isLoading(true);
    try {
      yield await usecase();
    } catch (e) {
      Get.snackbar('error all Products', e.toString());
      yield [];
    } finally {
      isLoading(false);
    }
  }
}
