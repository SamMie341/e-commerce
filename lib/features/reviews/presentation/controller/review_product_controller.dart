import 'package:e_commerce/features/reviews/data/model/review_id_model.dart';
import 'package:e_commerce/features/reviews/domain/usecase/review_detail_usecase.dart';
import 'package:get/get.dart';

class ReviewProductController extends GetxController {
  final ReviewDetailUseCase usecase;

  ReviewProductController(this.usecase);

  final RxList<ReviewIdModel> reviewIdList = <ReviewIdModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getReviewById(Get.arguments['id']);
  }

  Future<void> getReviewById(int id) async {
    try {
      isLoading.value = true;

      final result = await usecase.fetchReviewById(id);
      reviewIdList.assignAll([result]);
    } catch (e) {
      Get.snackbar('ຜິດພາດ', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
