import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;

  ProfileController(this.getProfileUseCase);

  Rxn<Profile> profile = Rxn<Profile>();
  var isLoading = false.obs;

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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('rememberMe');
    await prefs.remove('cart_items');
    // ไม่ลบ username เพื่อให้แสดงใน TextFormField เมื่อกลับมา login
    // await prefs.remove('u_email');
    Get.offAllNamed('/login');
  }

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }
}
