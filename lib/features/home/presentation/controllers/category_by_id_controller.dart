import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/home/domain/usecases/get_all_categoryDetail_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryByIdController extends GetxController {
  final GetAllCategoryDetailUseCase getAllCategoryDetailUseCase;

  CategoryByIdController(this.getAllCategoryDetailUseCase);

  final categoryList = <ProductModel>[].obs;

  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  int currentPage = 1;
  var expandedIndex = (-1).obs;
  final int limit = 10;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchCategoryById(Get.arguments['categoryId']);
  }

  Future<void> fetchCategoryById(int id, {int page = 1, int limit = 10}) async {
    if (isLoadingMore.value || !hasMore.value) return;
    try {
      isLoading.value = true;
      currentPage++;
      final result = await getAllCategoryDetailUseCase.callCategory(id,
          page: page, limit: limit);

      if (result.length < limit) {
        hasMore.value = false;
      }

      final newItems = result
          .where((news) => !categoryList.any((exist) => exist.id == news.id))
          .toList();
      categoryList.addAll(newItems);

      if (newItems.length < result.length) {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
