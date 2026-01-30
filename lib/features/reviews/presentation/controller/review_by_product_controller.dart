import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/reviews/data/model/review_by_product_model.dart';
import 'package:e_commerce/features/reviews/domain/usecase/review_detail_usecase.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewByProductController extends GetxController {
  final ReviewDetailUseCase usecase;

  ReviewByProductController(this.usecase);
  var isLoading = false.obs;
  var reviewByPro = <ReviewByProductModel>[].obs;
  var errorMessage = ''.obs;

  var unreadCount = 0.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // if (Get.arguments != null && Get.arguments['reviewId'] != null) {
  // fetchReviewByPro(Get.arguments['reviewId']);
  // }
  // }

  void fetchReviewByPro(int productId) async {
    isLoading(true);
    final result = await usecase.fetchReviewByPro(productId);
    result.fold((failure) {
      errorMessage.value = 'ໂຫຼດຂໍ້ມູນບໍ່ສຳເລັດ';
      isLoading(false);
    }, (success) async {
      reviewByPro.value = success;
      await _calculateUnreadCount(productId, success.length);
      isLoading(false);
    });
  }

  void deleteReview(int reviewId, int productId) async {
    isLoading(true);
    final result = await usecase.deleteReview(reviewId);
    result.fold((failure) {
      isLoading(false);
      showDialogError(
          'ລົບຣີວິວ',
          'ທ່ານແນ່ໃຈທີ່ຈະລົບຣີວິວບໍ?',
          duration: const Duration(seconds: 5),
          Get.context!);
    }, (success) {
      fetchReviewByPro(productId);
      showDialogSuccess('ສຳເລັດ', 'ລົບຣີວິວສຳເລັດ', Get.context!);
    });
  }

  void updateReview(
      int reviewId, int productId, int rating, String comment) async {
    isLoading(true);
    final result =
        await usecase.updateReview(reviewId, productId, rating, comment);
    result.fold((failure) {
      isLoading(false);
      showDialogError(
          'ຜິດພາດ',
          failure.message,
          duration: const Duration(seconds: 5),
          Get.context!);
    }, (success) {
      Get.back();
      fetchReviewByPro(productId);
      showDialogSuccess('ສຳເລັດ', 'ແກ້ໄຂຣີວິວສຳເລັດ', Get.context!);
    });
  }

  Future<void> _calculateUnreadCount(int productId, int totalReviews) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCount = prefs.getInt('read_reviews_product_$productId') ?? 0;

    if (totalReviews > savedCount) {
      unreadCount.value = totalReviews - savedCount;
    } else {
      unreadCount.value = 0;
    }
  }

  Future<void> markAsRead(int productId) async {
    if (unreadCount.value > 0) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('read_reviews_product_$productId', reviewByPro.length);
      unreadCount.value = 0;
    }
  }
}
