import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/profile/domain/usecases/buy_history_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/fetch_shop_status_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/request_shop_usecase.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final RequestShopUseCase requestShopUseCase;
  final FetchShopStatusUseCase fetchShopStatusUseCase;
  final BuyHistoryUseCase buyHistoryUseCase;

  ProfileController(this.getProfileUseCase, this.requestShopUseCase,
      this.fetchShopStatusUseCase, this.buyHistoryUseCase);

  Rxn<Profile> profile = Rxn<Profile>();

  var isLoading = false.obs;
  var isLoadingProfile = false.obs;
  var isLoadingHistory = false.obs;
  var isShopStatusLoading = false.obs;
  var hasShop = false.obs;
  final historyList = <OrderDetailModel>[].obs;
  final rememberMe = Utility.getSharedPreference('rememberMe');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController telController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    fetchProfile();
    fetchShopStatus();
    fetchHistory();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    try {
      isLoadingProfile.value = true;
      final result = await getProfileUseCase();
      profile.value = result;
    } catch (e) {
      Get.offAllNamed('/login');
    } finally {
      isLoadingProfile.value = false;
    }
  }

  Future<void> requestShop(String name, String tel) async {
    try {
      isLoading.value = true;
      final result = await requestShopUseCase(name, tel);
      result.fold(
        (failure) {
          Get.snackbar('Error', failure.message);
        },
        (success) {
          Get.back();
          showDialogSuccess(
            'ສຳເລັດ',
            'ສົ່ງຄຳຂໍເປີດຮ້ານສຳເລັດ',
            showConfirmBtn: true,
            Get.context!,
            btnConfirm: 'ຕົກລົງ',
            onConfirm: () => Get.back(),
          );
          clearTextOpenShop();
          fetchShopStatus();
        },
      );
    } catch (e) {
      Get.snackbar('Error Request Shop', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchShopStatus() async {
    isShopStatusLoading.value = true;
    final result = await fetchShopStatusUseCase();
    result.fold(
      (failure) => null,
      (status) {
        hasShop.value = status;
      },
    );
    isShopStatusLoading.value = false;
  }

  Future<void> fetchHistory() async {
    isLoadingHistory(true);
    final result = await buyHistoryUseCase();
    result.fold((failure) => null, (success) {
      historyList.value = success;
      isLoadingHistory(false);
    });
  }

  void clearTextOpenShop() {
    nameController.clear();
    telController.clear();
  }

  void logout() {
    Utility.removeSharedPreference('token');
    Utility.removeSharedPreference('cart_items');
    final rememberMe = Utility.getSharedPreference('rememberMe') ?? false;

    if (!rememberMe) {
      Utility.removeSharedPreference('username');
      Utility.removeSharedPreference('password');
      Utility.removeSharedPreference('rememberMe');
    }

    Get.offAllNamed('/login');
  }
}
