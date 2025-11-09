import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/profile/domain/usecases/fetch_shop_status_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/request_shop_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final RequestShopUseCase requestShopUseCase;
  final FetchShopStatusUseCase fetchShopStatusUseCase;

  ProfileController(this.getProfileUseCase, this.requestShopUseCase,
      this.fetchShopStatusUseCase);

  Rxn<Profile> profile = Rxn<Profile>();
  var isLoading = false.obs;
  var isShopStatusLoading = false.obs;
  var hasShop = false.obs;
  final rememberMe = Utility.getSharedPreference('rememberMe');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController telController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    fetchProfile();
    fetchShopStatus();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final result = await getProfileUseCase();
      profile.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
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
        (_) {
          Get.snackbar('Success', 'Your request has been sent successfully.');
          // อาจจะต้องการ fetch status ใหม่อีกครั้งหลังส่งคำขอ
          fetchShopStatus();
          Get.back(); // กลับไปหน้าก่อนหน้า
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
      (failure) => Get.snackbar('Error loading shop status', failure.message),
      (status) {
        hasShop.value = status;
      },
    );
    isShopStatusLoading.value = false;
  }

  void logout() {
    Utility.removeSharedPreference('token');
    Utility.removeSharedPreference('cart_items');
    // Utility.removeSharedPreference('userimg');
    final rememberMe = Utility.getSharedPreference('rememberMe') ?? false;

    if (!rememberMe) {
      Utility.removeSharedPreference('username');
      Utility.removeSharedPreference('password');
      Utility.removeSharedPreference('rememberMe');
    }

    Get.offAllNamed('/login');
  }
}
