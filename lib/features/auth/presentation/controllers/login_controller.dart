import 'package:e_commerce/features/auth/domain/entities/user.dart';
import 'package:e_commerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  var isLoading = false.obs;
  var error = ''.obs;
  final rememberMe = false.obs;
  final currentUser = Rxn<User>();

  Future<void> login(String username, String password, bool rememberMe) async {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'ແຈ້ງເຕືອນ',
        'ກະລູນາປ້ອນຂໍ້ມູນໃຫ້ຄົບຖ້ວນ',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    if (password.length < 6) {
      Get.snackbar(
        'ແຈ້ງເຕືອນ',
        'ລະຫັດຜ່ານຢ່າງນ້ອຍ 6 ຕົວອັກສອນ',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    try {
      isLoading.value = true;
      print('[Controller] login called');
      print('$username,$password');
      User user = await loginUseCase(username, password);
      currentUser.value = user;
      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", user.token);
        await prefs.setString("u_profile", user.userimg);
        await prefs.setBool('rememberMe', rememberMe);
        // เก็บ username ไว้เสมอเพื่อแสดงเมื่อ logout
        await prefs.setString('username', username);
      }
      Get.toNamed('/bottom');
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ฟังก์ชันสำหรับโหลด username ที่เก็บไว้
  Future<String?> getSavedusername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}
