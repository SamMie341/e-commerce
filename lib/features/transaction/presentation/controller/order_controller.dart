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
  // final orderProcessList = <OrderDetailModel>[].obs;
  // final orderCancelList = <OrderDetailModel>[].obs;

  Rxn<OrderDetailModel> orderSuccess = Rxn<OrderDetailModel>();

  final isLoading = false.obs;

  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  int currentPage = 1;
  var expandedIndex = (-1).obs;

  final int limit = 10;

  final ScrollController scrollController = ScrollController();

  // @override
  // void onInit() {
  //   // refresh();
  //   // fetchOrders();
  //   // scrollController.addListener(_scrollListener);
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   scrollController.dispose();
  //   super.onClose();
  // }

  // void _scrollListener() {
  //   if (scrollController.position.pixels ==
  //           scrollController.position.maxScrollExtent &&
  //       hasMore.value && !isLoadingMore.value) {}
  // }

  Stream<List<OrderDetailModel>> fetchOrders() async* {
    // if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoading(true);
      // currentPage++;
      final orders = await getAllOrderUseCase(page: currentPage, limit: limit);
      yield orders;

      // if (orders.length < limit) {
      //   hasMore.value = false;
      // }

      // final newItems = orders
      //     .where((newItem) => !orderList.any((newItems) => newItems.id == newItem.id))
      //     .toList();
      // orderList.addAll(newItems);

      // if (newItems.length < orders.length) {
      //   hasMore.value = false;
      // }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      yield []; // Yield an empty list or handle the error as needed
    } finally {
      isLoading(false);
    }
  }

  Stream<List<OrderDetailModel>> fetchOrderProcess() async* {
    try {
      isLoading(true);
      // currentPage++;
      final process =
          await getOrderProductUseCase(page: currentPage, limit: limit);
      yield process;

      // if (process.length < limit) {
      //   hasMore.value = false;
      // }

      // final newItems = process
      //     .where(
      //         (item) => !orderProcessList.any((items) => items.id == item.id))
      //     .toList();
      // orderProcessList.assignAll(process);

      // if (newItems.length < orderProcessList.length) {
      //   hasMore.value = false;
      // }
    } catch (e) {
      Get.snackbar('Error Order Process', e.toString());
      yield [];
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<OrderDetailModel>> fetchOrderCancel() async* {
    // if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoading.value = true;
      currentPage++;
      final cancel =
          await getOrderCancelUseCase(page: currentPage, limit: limit);
      yield cancel;

      // if (cancel.length < limit) {
      //   hasMore.value = false;
      // }

      // final newItems = orderCancelList
      //     .where((item) => !orderCancelList.any((items) => items.id == item.id))
      //     .toList();
      // orderCancelList.addAll(newItems);

      // if (newItems.length < orderCancelList.length) {
      //   hasMore.value = false;
      // }
    } catch (e) {
      Get.snackbar('Error Order Cancel', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<OrderDetailModel> fetchOrderById(int id) async {
    try {
      isLoading(true);
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
        await fetchOrders();
        expandedIndex = 0.obs;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    currentPage = 0;
    hasMore.value = true;
    await fetchOrders();
    await fetchOrderProcess();
    await fetchOrderCancel();
  }
}
