import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';
import 'package:e_commerce/features/notification/domain/usecase/accept_order_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_accept_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_order_product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductController extends GetxController {
  final GetOrderProductUseCase getOrderProductUseCase;
  final GetAcceptProductUseCase getAcceptProductUseCase;
  final AcceptOrderProductUseCase acceptOrderProductUseCase;

  OrderProductController(
    this.getOrderProductUseCase,
    this.getAcceptProductUseCase,
    this.acceptOrderProductUseCase,
  );

  final orderProductList = <OrderProductModel>[].obs;
  final orderAcceptList = <OrderProductModel>[].obs;

  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  int currentPage = 1;
  var expandedIndex = (-1).obs;
  final int limit = 10;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // fetchOrderProduct();
    // fetchAcceptProduct();
    loadMoreOrderProduct();
    loadMoreOrderAcceptProduct();
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
        !isLoadingMore.value) {
      loadMoreOrderProduct();
      loadMoreOrderAcceptProduct();
    }
  }

  Future<void> fetchOrderProduct() async {
    try {
      isLoading.value = true;
      final orderProduct =
          await getOrderProductUseCase(page: currentPage, limit: limit);

      if (orderProduct.length < limit) {
        hasMore.value = false;
      }

      if (currentPage == 1) {
        orderProductList.assignAll(orderProduct);
      } else {
        final newItems = orderProduct
            .where((newItem) => !orderProductList
                .any((existingItem) => existingItem.id == newItem.id))
            .toList();
        orderProductList.addAll(newItems);

        if (newItems.length < orderProduct.length) {
          hasMore.value = false;
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAcceptProduct() async {
    try {
      isLoading.value = true;
      final orderProduct =
          await getAcceptProductUseCase(page: currentPage, limit: limit);

      if (orderProduct.length < limit) {
        hasMore.value = false;
      }

      if (currentPage == 1) {
        orderAcceptList.assignAll(orderProduct);
      } else {
        final newItems = orderProduct
            .where((newItem) => !orderAcceptList
                .any((existingItem) => existingItem.id == newItem.id))
            .toList();
        orderAcceptList.addAll(newItems);

        if (newItems.length < orderProduct.length) {
          hasMore.value = false;
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptOrder(
    int orderId,
    int productstatusId,
    BuildContext context,
  ) async {
    try {
      isLoading.value = true;
      await acceptOrderProductUseCase.call(orderId, productstatusId);

      if (orderProductList.isNotEmpty && orderAcceptList.isNotEmpty) {
        fetchOrderProduct();
        fetchAcceptProduct();
        expandedIndex;
      }
      // fetchOrderProduct();
      // fetchAcceptProduct();

      showDialogSuccess(context, 'ສຳເລັດ', 'ຮັບອໍເດີ້ສຳເລັດ');
    } catch (e) {
      showDialogError(
        context,
        'ຜິດພາດ',
        'ເກີດຂໍ້ຜິດພາດໃນການຮັບຄຳສັ່ງຊື້',
        Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreOrderProduct() async {
    if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoadingMore.value = true;
      currentPage++;
      final orderProduct =
          await getOrderProductUseCase(page: currentPage, limit: limit);

      if (orderProduct.length < limit) {
        hasMore.value = false;
      }

      // ตรวจสอบข้อมูลซ้ำก่อนเพิ่ม
      final newItems = orderProduct
          .where((newItem) => !orderProductList
              .any((existingItem) => existingItem.id == newItem.id))
          .toList();
      orderProductList.addAll(newItems);

      if (newItems.length < orderProduct.length) {
        // ถ้ามีข้อมูลซ้ำ แสดงว่าไม่มีข้อมูลใหม่
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMoreOrderAcceptProduct() async {
    if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoadingMore.value = true;
      currentPage++;
      final orderAcceptProduct =
          await getAcceptProductUseCase(page: currentPage, limit: limit);

      if (orderAcceptProduct.length < limit) {
        hasMore.value = false;
      }

      final newItems = orderAcceptProduct
          .where((newItem) => !orderAcceptList
              .any((existingItem) => existingItem.id == newItem.id))
          .toList();
      orderAcceptList.addAll(newItems);

      if (newItems.length < orderAcceptProduct.length) {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refresh() async {
    currentPage = 1;
    hasMore.value = true;
    await fetchOrderProduct();
    await fetchAcceptProduct();
  }
}
