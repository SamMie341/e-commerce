import 'dart:io';

import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/payment/data/models/payment_model.dart';
import 'package:e_commerce/features/payment/domain/usecase/payment_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PaymentController extends GetxController {
  final PaymentUseCase paymentUseCase;

  PaymentController(this.paymentUseCase);

  final isLoading = false.obs;

  final RxList<PaymentModel> paymentList = <PaymentModel>[].obs;

  final Rx<ImagePicker> picker = ImagePicker().obs;
  var imageFile = Rx<File?>(null);

  @override
  void onInit() {
    getPaymentById(Get.arguments['id']);
    super.onInit();
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
      final result = await paymentUseCase.call(id);
      paymentList.assignAll([result]);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> payment(BuildContext context, int orderId, int productstatusId,
      String comment, File payimg) async {
    try {
      isLoading.value = true;
      await paymentUseCase.payment(orderId, productstatusId, comment, payimg);
      showDialogSuccess(context, 'ສຳເລັດ', 'ຊຳລະສຳເລັດ ລໍຖ້າການຢືນຢັນ');
    } catch (e) {
      showDialogError(context, 'ຜຶດພາດ', '', Duration(seconds: 5));
    } finally {
      isLoading.value = false;
    }
  }
}
