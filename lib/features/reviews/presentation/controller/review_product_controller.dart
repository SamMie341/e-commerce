import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/reviews/domain/usecase/review_detail_usecase.dart';
import 'package:get/get.dart';

class ReviewProductController extends GetxController {
  final ReviewDetailUseCase usecase;

  ReviewProductController(this.usecase);

  // final reviewIdList = <ReviewIdModel>[].obs;
  Rxn<ProductModel> reviewIdList = Rxn<ProductModel>();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getReviewById(Get.arguments['reviewId']);
  }

  Future<void> getReviewById(int id) async {
    try {
      isLoading.value = true;

      final result = await usecase.fetchReviewById(id);
      reviewIdList.value = result;
    } catch (e) {
      // Get.snackbar('ຜິດພາດ Review', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
