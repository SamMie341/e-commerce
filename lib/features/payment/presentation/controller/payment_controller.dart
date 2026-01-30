import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/payment/data/models/payment_model.dart';
import 'package:e_commerce/features/payment/domain/usecase/bank_usecase.dart';
import 'package:e_commerce/features/payment/domain/usecase/payment_usecase.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';

class PaymentController extends GetxController {
  final PaymentUseCase paymentUseCase;
  final BankUseCase bankUseCase;

  PaymentController(this.paymentUseCase, this.bankUseCase);

  final orderController = Get.find<OrderController>();

  final isLoading = false.obs;

  final paymentList = Rx<PaymentModel?>(null);

  final bankList = <BankModel>[].obs;

  // final Rx<ImagePicker> picker = ImagePicker().obs;

  var imageFile = Rx<File?>(null);

  final imageSaver = ImageGallerySaver();

  final TextEditingController commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getPaymentById(Get.arguments['orderDetailId']);
    // fetchBank();
  }

  Future<void> pickImage() async {
    if (Get.context == null) return;

    try {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          textDelegate: EnglishAssetPickerTextDelegate(),
        ),
      );

      if (result != null && result.isNotEmpty) {
        final File? file = await result.first.file;

        if (file != null) {
          imageFile.value = file;
        }
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
  // ------------------------------------------

  Future<void> getPaymentById(int id) async {
    isLoading(true);
    try {
      final result = await paymentUseCase(id);
      paymentList.value = result;
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> payment() async {
    if (imageFile.value == null) {
      showDialogError(
        'ຜິດພາດ',
        'ກະລຸນາເພີ່ມຮູບຢືນຢັນການໂອນ',
        duration: const Duration(seconds: 5),
        Get.context!,
      );
      return;
    }
    isLoading(true);
    try {
      final data = PayModel(
        orderId: paymentList.value!.id,
        productstatusId: 4,
        comment: commentController.text,
        payimg: imageFile.value!,
      );
      final result = await paymentUseCase.payment(data);
      result.fold(
        (failure) => showDialogError(
          'ຜິດພາດ',
          failure.message,
          duration: const Duration(seconds: 5),
          Get.context!,
        ),
        (success) {
          Get.back();
          showDialogSuccess(
            'ສຳເລັດ',
            'ຊຳລະສຳເລັດ ລໍຖ້າການຢືນຢັນການຊຳລະ',
            Get.context!,
            showConfirmBtn: true,
            btnConfirm: 'ຕົກລົງ',
            onConfirm: () {
              orderController.fetchOrderProcess();
              Get.back();
            },
          );
        },
      );
    } catch (e) {
      // showDialogError('ຜິດພາດ', e.toString(), Duration(seconds: 5), context);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchBank(int id) async {
    isLoading(true);
    try {
      final result = await bankUseCase(id);
      result.fold((failure) => Get.snackbar('Error QR', failure.message), (
        success,
      ) {
        bankList.assignAll(success);
      });
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> downloadQRCode(String qrCodeUrl, String bankName) async {
    if (qrCodeUrl.isEmpty) {
      Get.snackbar('Error', 'ບໍ່ມີ URL QR Code');
      return;
    }

    bool hasPermission = false;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        hasPermission = true;
      } else {
        var status = await Permission.storage.request();
        hasPermission = status.isGranted;
      }
    } else {
      // iOS
      hasPermission = await Permission.photosAddOnly.request().isGranted ||
          await Permission.photos.request().isGranted;
    }

    if (hasPermission) {
      try {
        Get.snackbar(
          'Processing',
          'ກຳລັງບັນທຶກ QR...',
          showProgressIndicator: true,
        );

        var response = await Dio().get(
          qrCodeUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        await imageSaver.saveImage(Uint8List.fromList(response.data));

        Get.snackbar(
          'ສຳເລັດ',
          'ບັນທຶກ QR Code ລົງ Gallery ແລ້ວ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } catch (e) {
        Get.snackbar('Error', 'ເກີດຂໍ້ຜິດພາດ: $e');
      }
    } else {
      Get.snackbar(
        'Permission Denied',
        'ກະລຸນາເປີດສິດການເຂົ້າເຖິງຮູບພາບ',
        mainButton: TextButton(
          onPressed: () => openAppSettings(),
          child: Text('Settings'),
        ),
      );
    }
  }
}
