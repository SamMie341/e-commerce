import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';
import 'package:e_commerce/features/notification/domain/usecase/accept_order_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_accept_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_order_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_order_seller_by_id_usecase.dart';
import 'package:get/get.dart';

class OrderProductController extends GetxController {
  final GetOrderProductUseCase getOrderProductUseCase;
  final GetAcceptProductUseCase getAcceptProductUseCase;
  final AcceptOrderProductUseCase acceptOrderProductUseCase;
  final GetOrderSellerByIdUseCase getOrderSellerByIdUseCase;

  OrderProductController(
    this.getOrderProductUseCase,
    this.getAcceptProductUseCase,
    this.acceptOrderProductUseCase,
    this.getOrderSellerByIdUseCase,
  );

  final orderProductList = <OrderProductModel>[].obs;
  final orderAcceptList = <OrderProductModel>[].obs;
  Rxn<OrderProductModel> orderProductById = Rxn<OrderProductModel>();

  final isLoading = false.obs;

  var context = Get.context!;

  @override
  void onInit() {
    super.onInit();
    fetchOrderProduct();
    fetchAcceptProduct();
  }

  Stream<List<OrderProductModel>> fetchOrderProduct() async* {
    try {
      isLoading(true);
      final orderProduct = await getOrderProductUseCase();
      // orderProductList.assignAll(orderProduct);
      yield orderProduct;
    } catch (e) {
      Get.snackbar('Error order product', e.toString());
      yield [];
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAcceptProduct() async {
    try {
      isLoading.value = true;
      final orderProduct = await getAcceptProductUseCase();
      orderAcceptList.assignAll(orderProduct);
    } catch (e) {
      Get.snackbar('Error Accept product', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadOrderSellerById(int id) async {
    isLoading(true);
    try {
      final result = await getOrderSellerByIdUseCase(id);
      orderProductById.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> acceptOrder(int orderId, int productstatusId) async {
    try {
      isLoading.value = true;
      await acceptOrderProductUseCase.call(orderId, productstatusId);
      showDialogSuccess(context: context, 'ສຳເລັດ', 'ຮັບອໍເດີ້ສຳເລັດ');
    } catch (e) {
      showDialogError(
        context: context,
        'ຜິດພາດ',
        'ເກີດຂໍ້ຜິດພາດໃນການຮັບຄຳສັ່ງຊື້',
        Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    await fetchOrderProduct();
    await fetchAcceptProduct();
  }
}
