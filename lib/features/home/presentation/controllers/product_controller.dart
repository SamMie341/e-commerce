import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/home/domain/entities/products_entity.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final GetAllProductUseCase getAllProductUseCase;

  ProductController(this.getAllProductUseCase);

  final productList = <Product>[].obs;
  final isLoading = false.obs;

  Rxn<ProductModel> productDetail = Rxn<ProductModel>();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final products = await getAllProductUseCase();
      productList.assignAll(products);
      productList.refresh();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
