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

  final orderList = <OrderDetailModel>[].obs;

  Rxn<OrderDetailModel> orderSuccess = Rxn<OrderDetailModel>();

  final isLoading = false.obs;

  Stream<List<OrderDetailModel>> fetchOrders() async* {
    try {
      isLoading(true);
      final orders = await getAllOrderUseCase();
      yield orders;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      yield [];
    } finally {
      isLoading(false);
    }
  }

  Stream<List<OrderDetailModel>> fetchOrderProcess() async* {
    try {
      isLoading(true);
      final process = await getOrderProductUseCase();
      yield process;
    } catch (e) {
      Get.snackbar('Error Order Process', e.toString());
      yield [];
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<OrderDetailModel>> fetchOrderCancel() async* {
    try {
      isLoading.value = true;
      final cancel = await getOrderCancelUseCase();
      yield cancel;
    } catch (e) {
      Get.snackbar('Error Order Cancel', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<OrderDetailModel> fetchOrderById(int id) async {
    isLoading(true);
    try {
      final result = await getAllOrderUseCase.callById(id);
      return orderSuccess.value = result;
    } catch (e) {
      Get.snackbar('Fail to load detail order', e.toString());
    }
    isLoading(false);
    throw Exception();
  }

  Future<void> deleteOrder(int id) async {
    try {
      isLoading.value = true;
      await deleteUseCase(id);
      if (orderList.isNotEmpty) {
        fetchOrders();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
