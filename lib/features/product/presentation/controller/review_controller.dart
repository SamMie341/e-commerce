import 'package:e_commerce/features/product/data/model/review_model.dart';
import 'package:e_commerce/features/product/domain/usecases/get_review_usecase.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  final GetReviewUseCase usecase;

  ReviewController(this.usecase);

  final isLoading = false.obs;
  final reviewList = <Review>[].obs;

  @override
  void onInit() {
    loadReview(Get.arguments['id']);
    super.onInit();
  }

  Future<void> loadReview(int productId) async {
    try {
      isLoading.value = true;
      final result = await usecase(productId);
      reviewList.assignAll(result);
    } catch (e) {
      Get.snackbar('Fail to load Review', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
