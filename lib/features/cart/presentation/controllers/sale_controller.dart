import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/cart/domain/usecase/sale_usecase.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:get/get.dart';

class SaleController extends GetxController {
  final SaleUseCase saleUseCase;

  SaleController(this.saleUseCase);

  var isLoading = false.obs;
  var selectedItem = <Map<String, dynamic>>[].obs;
  var context = Get.context!;
  final OrderController orderController = Get.find();

  Future<void> submitSale(List<Map<String, dynamic>> data) async {
    if (data.isEmpty) {
      Get.back();
      Get.snackbar('ແຈ້ງເຕືອນ', 'ບໍ່ມີສິນຄ້າໃນກະຕ່າ');
    }

    try {
      isLoading(true);
      final result = await saleUseCase.call(data);
      result.fold(
          (failure) => showDialogError(
              'ຜິດພາດ',
              failure.message,
              duration: const Duration(seconds: 5),
              context), (success) {
        orderController.fetchOrders();
        showDialogSuccess(
            'ສຳເລັດ',
            'ສັ່ງຊື້ສຳເລັດ ລໍຖ້າການຕອບຮັບອໍເດີຈາກທາງຮ້ານຄ້າ',
            showConfirmBtn: true,
            btnConfirm: 'ກັບຄືນ',
            onConfirm: () => Get.back(),
            context);
      });
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
