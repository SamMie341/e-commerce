import 'package:e_commerce/core/utils/device_helper.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/auth/domain/entities/user.dart';
import 'package:e_commerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  var isLoading = false.obs;
  var error = ''.obs;
  final rememberMes = false.obs;
  final currentUser = Rxn<User>();
  final RxBool isShow = true.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // var context = Get.context!;

  @override
  void onInit() {
    super.onInit();
    getSavedUsername();
  }

  // Future<void> login(String username, String password, bool rememberMe) async {
  //   isLoading(true);
  //   try {
  //     String? fcmToken = await FirebaseMessaging.instance.getToken();
  //     Map<String, String> deviceInfo = await DeviceHelper.getDeviceInfo();
  //     String platform = deviceInfo['platform'] ?? 'unknown';
  //     String deviceModel = deviceInfo['model'] ?? 'unknown';
  //     print('fcm token: $fcmToken');
  //     print('platform: $platform');
  //     print('model: $deviceModel');
  //     final result = await loginUseCase(
  //         username, password, fcmToken!, platform, deviceModel, rememberMe);
  //     result.fold((failure) {
  //       error.value = failure.message;
  //       showDialogError(
  //           'ຜິດພາດ',
  //           failure.message,
  //           duration: const Duration(seconds: 10),
  //           Get.context!);
  //       return;
  //     }, (user) {
  //       currentUser.value = user;
  //       Get.offAllNamed('/bottom');
  //     });
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> login(String username, String password, bool rememberMe) async {
    isLoading(true);
    String fcmToken = '';
    try {
      fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
      Map<String, String> deviceInfo = await DeviceHelper.getDeviceInfo();
      String platform = deviceInfo['platform'] ?? 'unknown';
      String deviceModel = deviceInfo['model'] ?? 'unknown';
      print('fcm token: $fcmToken');
      print('platform: $platform');
      print('model: $deviceModel');
      final result = await loginUseCase(
          username, password, fcmToken, platform, deviceModel, rememberMe);
      result.fold((failure) {
        error.value = failure.message;
        showDialogError(
            'ຜິດພາດ',
            failure.message,
            duration: const Duration(seconds: 10),
            Get.context!);
        return;
      }, (user) {
        currentUser.value = user;
        Get.offAllNamed('/bottom');
      });
    } catch (e) {
      fcmToken = 'dummy_token_for_emulator';
    } finally {
      isLoading.value = false;
    }
  }

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
