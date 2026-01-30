import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/domain/usecase/delete_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_cancel_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_process_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_usecase.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderUseCase getAllOrderUseCase;
  final DeleteUseCase deleteUseCase;
  final OrderProcessUseCase getOrderProductUseCase;
  final OrderCancelUseCase getOrderCancelUseCase;

  OrderController(
    this.getAllOrderUseCase,
    this.deleteUseCase,
    this.getOrderProductUseCase,
    this.getOrderCancelUseCase,
  );

  final orderSuccessList = <OrderDetailModel>[].obs;
  final orderProcessList = <OrderDetailModel>[].obs;
  final orderCancelList = <OrderDetailModel>[].obs;

  final orderDetail = Rxn<OrderDetailModel>();

  final isLoading = false.obs;
  final isDetailLoading = false.obs;

  @override
  void onInit() {
    fetchOrders();
    fetchOrderProcess();
    fetchOrderCancel();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    isLoading(true);
    try {
      final result = await getAllOrderUseCase.call();
      orderSuccessList.assignAll(result);
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchOrderProcess() async {
    isLoading(true);
    try {
      final result = await getOrderProductUseCase();
      orderProcessList.assignAll(result);
    } catch (e) {
      // Get.snackbar('Error Order Process', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchOrderCancel() async {
    try {
      isLoading.value = true;
      final result = await getOrderCancelUseCase();
      orderCancelList.assignAll(result);
    } catch (e) {
      // Get.snackbar('Error Order Cancel', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<OrderDetailModel> fetchOrderById(int id) async {
    isDetailLoading(true);
    try {
      orderDetail.value = await getAllOrderUseCase.callById(id);
      return orderDetail.value!;
    } catch (e) {
      rethrow;
    } finally {
      isDetailLoading(false);
    }
  }

  Future<void> deleteOrder(int id) async {
    try {
      isLoading.value = true;
      await deleteUseCase(id);
      if (orderSuccessList.isNotEmpty) {
        fetchOrders();
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    fetchOrders();
    fetchOrderProcess();
    fetchOrderCancel();
  }
}
