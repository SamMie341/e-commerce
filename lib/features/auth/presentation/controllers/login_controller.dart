import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/auth/domain/entities/user.dart';
import 'package:e_commerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  var isLoading = false.obs;
  var error = ''.obs;
  final rememberMes = false.obs;
  final currentUser = Rxn<User>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getSavedUsername();
  }

  Future<void> login(String username, String password, bool rememberMe) async {
    isLoading.value = true;
    try {
      final result = await loginUseCase(username, password, rememberMe);
      result.fold((failure) {
        error.value = failure.message;

        Utility.customAlertDialog(
            titleHeader: "ຜິດພາດ",
            message: failure.message,
            onPressed: () => Get.back());
        // Get.snackbar(
        //   'ຜິດພາດ',
        //   failure.message,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );
      }, (user) {
        currentUser.value = user;
        Get.offAllNamed('/bottom');
      });
    } finally {
      isLoading.value = false;
    }
  }

  // ฟังก์ชันสำหรับโหลด username ที่เก็บไว้
  void getSavedUsername() {
    final remember = Utility.getSharedPreference('rememberMe');
    if (remember != true || remember == null) {
      usernameController.text = '';
    }
    usernameController.text = Utility.getSharedPreference('username') ?? '';
    passwordController.text = Utility.getSharedPreference('password') ?? '';
    rememberMes.value = Utility.getSharedPreference('rememberMe') ?? false;
  }
}
