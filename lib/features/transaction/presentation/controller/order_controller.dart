import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/domain/usecase/delete_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_cancel_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_process_usecase.dart';
import 'package:e_commerce/features/transaction/domain/usecase/order_usecase.dart';
import 'package:flutter/material.dart';
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
  final orderProcess = <OrderDetailModel>[].obs;
  final orderCancel = <OrderDetailModel>[].obs;

  final isLoading = false.obs;

  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  int currentPage = 1;
  var expandedIndex = (-1).obs;

  final int limit = 10;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    fetchOrders();
    fetchOrderProcess();
    fetchOrderCancel();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        hasMore.value &&
        !isLoadingMore.value) {}
  }

  Future<void> fetchOrders() async {
    if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoading.value = true;
      currentPage++;
      final orders = await getAllOrderUseCase(page: currentPage, limit: limit);

      if (orders.length < limit) {
        hasMore.value = false;
      }

      final newItems = orders
          .where((newItem) =>
              !orderList.any((newItems) => newItems.id == newItem.id))
          .toList();
      orders.addAll(newItems);

      if (newItems.length < orders.length) {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrderProcess() async {
    try {
      isLoading.value = true;
      currentPage++;
      final process =
          await getOrderProductUseCase(page: currentPage, limit: limit);

      if (process.length < limit) {
        hasMore.value = false;
      }

      final newItems = process
          .where((item) => !orderProcess.any((items) => items.id == item.id))
          .toList();
      orderProcess.addAll(newItems);

      if (newItems.length < orderProcess.length) {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrderCancel() async {
    try {
      isLoading.value = true;
      currentPage++;
      final cancel =
          await getOrderCancelUseCase(page: currentPage, limit: limit);

      if (cancel.length < limit) {
        hasMore.value = false;
      }

      final newItems = orderCancel
          .where((item) => !orderCancel.any((items) => items.id == item.id))
          .toList();
      orderCancel.addAll(newItems);

      if (newItems.length < orderCancel.length) {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteOrder(int id) async {
    try {
      isLoading.value = true;
      await deleteUseCase(id);
      Get.snackbar(
        'ສຳເລັດ',
        'ລົບສິນຄ້າສຳເລັດ',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      fetchOrderProcess();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
