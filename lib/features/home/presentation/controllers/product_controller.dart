import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final GetAllProductUseCase getAllProductUseCase;

  ProductController(this.getAllProductUseCase);

  final productList = <ProductModel>[].obs;

  final filteredProductList = <ProductModel>[].obs;

  final isLoading = false.obs;

  var isSearching = false.obs;
  var searchText = ''.obs;

  Rxn<ProductModel> productDetail = Rxn<ProductModel>();
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading(true);
    try {
      final products = await getAllProductUseCase();
      productList.assignAll(products);
      filteredProductList.assignAll(products);
    } catch (e) {
      Get.snackbar('ການສະແດງສິນຄ້າ', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void filterProduct(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredProductList.assignAll(productList);
    } else {
      filteredProductList.assignAll(productList.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchText.value = '';
      searchController.clear();
      filteredProductList.assignAll(productList);
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
