import 'package:e_commerce/features/favorite/data/model/favor_model.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';
import 'package:e_commerce/features/favorite/domain/usecase/favor_request_usecase.dart';
import 'package:e_commerce/features/favorite/domain/usecase/favor_usecase.dart';
import 'package:get/get.dart';

class FavorController extends GetxController {
  final FavorUseCase favorUseCase;
  final toggleFavorUseCase toggleUseCase;

  FavorController(this.favorUseCase, this.toggleUseCase);

  final favorList = <FavorModel>[].obs;
  final isLoading = false.obs;
  final isSelected = false.obs;

  var context = Get.context!;

  @override
  void onInit() {
    super.onInit();
    fetchFavor();
  }

  void fetchFavor() async {
    isLoading(true);
    try {
      final result = await favorUseCase();
      result.fold((failure) => null, (success) {
        favorList.value = success.map((f) => f).toList();
      });
    } catch (e) {
      return;
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleFavorite(FavoriteRequest product) async {
    final newFavorite = !product.favorite;
    isLoading(true);
    try {
      final result = await toggleUseCase(FavoriteRequest(
          productId: product.productId, favorite: product.favorite));
      result.fold((failure) => null, (success) {
        product.favorite = newFavorite;
        fetchFavor();
      });
    } finally {
      isLoading(false);
    }
  }
}
