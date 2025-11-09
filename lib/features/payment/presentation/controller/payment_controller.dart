import 'dart:io';

import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/payment/data/models/payment_model.dart';
import 'package:e_commerce/features/payment/domain/usecase/payment_usecase.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PaymentController extends GetxController {
  final PaymentUseCase paymentUseCase;

  PaymentController(this.paymentUseCase);

  final orderController = Get.find<OrderController>();

  final isLoading = false.obs;

  final Rxn<PaymentModel> paymentList = Rxn<PaymentModel>();

  final Rx<ImagePicker> picker = ImagePicker().obs;
  var imageFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    getPaymentById(Get.arguments['id']);
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await picker.value.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> getPaymentById(int id) async {
    try {
      isLoading.value = true;
      final result = await paymentUseCase(id);
      paymentList.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> payment(
      int orderId, int productstatusId, String comment, File payimg) async {
    try {
      isLoading.value = true;
      await paymentUseCase.payment(orderId, productstatusId, comment, payimg);
      orderController.refresh();
      showDialogSuccess('ສຳເລັດ', 'ຊຳລະສຳເລັດ ລໍຖ້າການຢືນຢັນການຊຳລະ');
    } catch (e) {
      showDialogError('ຜຶດພາດ', '', Duration(seconds: 5));
    } finally {
      isLoading.value = false;
    }
  }
}
