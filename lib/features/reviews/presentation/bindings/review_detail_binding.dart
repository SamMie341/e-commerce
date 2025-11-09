import 'package:e_commerce/features/reviews/data/datasource/review_detail_remote.dart';
import 'package:e_commerce/features/reviews/domain/repository/review_repositories.dart';
import 'package:e_commerce/features/reviews/domain/usecase/review_detail_usecase.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_detail_controller.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_product_controller.dart';
import 'package:get/get.dart';

class ReviewDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewDetailRemoteDatasource>(
        () => ReviewDetailRemoteDataSourceImpl());
    Get.lazyPut<ReviewDetailRepository>(
        () => ReviewDetailRepositoryImpl(Get.find()));
    Get.lazyPut(() => ReviewDetailUseCase(Get.find()));
    Get.lazyPut(() => ReviewDetailController(Get.find()));

    Get.lazyPut(() => ReviewProductController(Get.find()));
  }
}
