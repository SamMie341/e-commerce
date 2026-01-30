import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/reviews/data/model/review_model.dart';
import 'package:e_commerce/features/reviews/domain/usecase/review_detail_usecase.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_by_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewDetailController extends GetxController {
  final ReviewDetailUseCase reviewDetailUseCase;

  ReviewDetailController(this.reviewDetailUseCase);

  final reviewDetailList = <ReviewModel>[].obs;

  final TextEditingController reviewController = TextEditingController();

  final isLoading = false.obs;

  final ScrollController scrollController = ScrollController();

  final reviewsController = Get.find<ReviewByProductController>();

  var context = Get.context;

  @override
  void onInit() {
    super.onInit();
    fetchReviewDetail();
  }

  Future<void> fetchReviewDetail() async {
    try {
      isLoading.value = true;
      final reviews = await reviewDetailUseCase.call();

      reviewDetailList.assignAll(reviews);
    } catch (e) {
      return;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postReview(
    int productId,
    int rating,
    String comment,
  ) async {
    isLoading.value = true;
    try {
      final result =
          await reviewDetailUseCase.postReview(productId, rating, comment);
      result.fold(
          (failure) => showDialogError('ຜິດພາດ', failure.message, Get.context!,
              duration: const Duration(seconds: 5)), (success) {
        reviewController.clear();
        // Get.back();
        reviewsController.fetchReviewByPro(Get.arguments['reviewId']);
        showDialogSuccess(
          'ສຳເລັດ',
          'ຣີວິວສຳເລັດ',
          context!,
        );
      });
    } catch (e) {
      showDialogError(
          'ຜິດພາດ', e.toString(), duration: Duration(seconds: 5), context!);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }
}
