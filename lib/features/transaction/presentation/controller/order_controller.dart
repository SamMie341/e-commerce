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

  late Future<OrderDetailModel> orderDetailFuture;
  var isSeller = false.obs;
  late int orderId;

  void setOrderDetailFromArgs(dynamic args) {
    if (args != null) {
      int? currentOrderId;

      if (args is Map) {
        final rawId = args['orderId'];
        if (rawId is int) {
          currentOrderId = rawId;
        } else if (rawId != null) {
          currentOrderId = int.tryParse(rawId.toString());
        }

        final statusIdRaw = args['statusId'] ?? args['status'];
        final int statusId = int.tryParse(statusIdRaw?.toString() ?? '') ?? 0;

        // roles mapping based on status
        // Seller: 1, 4, 7
        // Buyer: 3, 5, 6
        // Both: 2

        if ([1, 4, 7].contains(statusId)) {
          isSeller.value = true;
        } else if ([3, 5, 6].contains(statusId)) {
          isSeller.value = false;
        } else {
          isSeller.value = args['isSeller'] ?? false;
        }
      } else if (args is int) {
        currentOrderId = args;
      } else if (args is String) {
        currentOrderId = int.tryParse(args);
      }

      if (currentOrderId != null) {
        orderId = currentOrderId;
        orderDetailFuture = fetchOrderById(orderId);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    fetchOrders();
    fetchOrderProcess();
    fetchOrderCancel();

    setOrderDetailFromArgs(Get.arguments);
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
