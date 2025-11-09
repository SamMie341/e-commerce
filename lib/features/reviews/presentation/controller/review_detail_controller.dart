import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/reviews/data/model/review_model.dart';
import 'package:e_commerce/features/reviews/domain/usecase/review_detail_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewDetailController extends GetxController {
  final ReviewDetailUseCase reviewDetailUseCase;

  ReviewDetailController(this.reviewDetailUseCase);

  final reviewDetailList = <ReviewModel>[].obs;

  final TextEditingController reviewController = TextEditingController();

  final isLoading = false.obs;
  final hasMore = true.obs;

  int currentPage = 1;

  var expendedIndex = (-1).obs;

  final int limit = 10;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchReviewDetail();
  }

  Future<void> fetchReviewDetail() async {
    try {
      isLoading.value = true;
      currentPage++;
      final reviews =
          await reviewDetailUseCase.call(page: currentPage, limit: limit);

      if (reviews.length < limit) {
        hasMore.value = false;
      }

      final newReviews = reviews
          .where((newReview) => !reviewDetailList
              .any((newReviewss) => newReviewss.id == newReview.id))
          .toList();
      reviewDetailList.assignAll(newReviews);

      if (newReviews.length < reviews.length) {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar('ຜິດພາດ', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postReview(
    int productId,
    int rating,
    String comment,
  ) async {
    try {
      isLoading.value = true;

      // if (productId.toString().isEmpty && rating.toString().isEmpty) {
      //   showDialogError(context!, 'ຜິດພາດ', '', Duration(seconds: 5));
      // }

      await reviewDetailUseCase.postReview(productId, rating, comment);
      showDialogSuccess('ສຳເລັດ', 'ຣີວິວສຳເລັດ');
    } catch (e) {
      showDialogError('ຜິດພາດ', e.toString(), Duration(seconds: 5));
    } finally {
      isLoading.value = false;
    }
  }
}
