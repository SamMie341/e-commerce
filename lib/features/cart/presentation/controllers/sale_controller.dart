import 'package:e_commerce/features/cart/domain/usecase/sale_usecase.dart';
import 'package:get/get.dart';

class SaleController extends GetxController {
  final SaleUseCase saleUseCase;

  SaleController(this.saleUseCase);

  var isLoading = false.obs;

  Future<void> submitSale(List<Map<String, dynamic>> data) async {
    if (data.isEmpty) {
      Get.snackbar('ແຈ້ງເຕືອນ', 'ບໍ່ມີສິນຄ້າໃນກະຕ່າ');
      return;
    }

    try {
      isLoading.value = true;
      await saleUseCase.call(data);
      Get.snackbar('Success', 'Order created Successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
