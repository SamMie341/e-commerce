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

  @override
  void onInit() {
    super.onInit();
    fetchFavor();
  }

  Future<void> fetchFavor() async {
    isLoading(true);
    try {
      final favor = await favorUseCase();
      favorList.assignAll(favor);
    } catch (e) {
      Get.snackbar('Error to fetch favorite', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleFavorite(FavoriteRequest product) async {
    final newFavorite = !product.favorite;
    try {
      await toggleUseCase(FavoriteRequest(
          productId: product.productId, favorite: product.favorite));
      product.favorite = newFavorite;
      fetchFavor();
      print(product.favorite = newFavorite);
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to update favorite');
    }
  }
}
