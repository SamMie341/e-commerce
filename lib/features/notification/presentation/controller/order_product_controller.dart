import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';
import 'package:e_commerce/features/notification/domain/usecase/accept_order_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_accept_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_order_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_order_seller_by_id_usecase.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_detail_controller.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductController extends GetxController {
  final GetOrderProductUseCase? getOrderProductUseCase;
  final GetAcceptProductUseCase? getAcceptProductUseCase;
  final AcceptOrderProductUseCase? acceptOrderProductUseCase;
  final GetOrderSellerByIdUseCase? getOrderSellerByIdUseCase;

  OrderProductController({
    this.getOrderProductUseCase,
    this.getAcceptProductUseCase,
    this.acceptOrderProductUseCase,
    this.getOrderSellerByIdUseCase,
  });

  final TextEditingController commentController = TextEditingController();

  final orderProductList = <OrderProductModel>[].obs;
  final orderAcceptList = <OrderProductModel>[].obs;
  Rxn<OrderProductModel> orderProductById = Rxn<OrderProductModel>();

  final orderController = Get.find<OrderController>();
  final reviewController = Get.find<ReviewDetailController>();

  final isLoading = false.obs;

  var context = Get.context!;
  @override
  void onInit() {
    fetchOrderProduct();
    fetchAcceptProduct();
    super.onInit();
  }

  Future<void> fetchOrderProduct() async {
    try {
      isLoading.value = true;
      final orderProduct = await getOrderProductUseCase!();
      orderProductList.assignAll(orderProduct);
    } catch (e) {
      // Get.snackbar('Error order product', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAcceptProduct() async {
    try {
      isLoading.value = true;
      final orderProduct = await getAcceptProductUseCase!();
      orderAcceptList.assignAll(orderProduct);
    } catch (e) {
      // Get.snackbar('Error Accept product', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadOrderSellerById(int id) async {
    isLoading(true);
    try {
      final result = await getOrderSellerByIdUseCase!(id);
      orderProductById.value = result;
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> acceptOrder(int orderId, int productstatusId,
      {String? comment}) async {
    try {
      if (acceptOrderProductUseCase == null) {
        throw Exception("UseCase not initialized");
      }

      final result = await acceptOrderProductUseCase!(
        orderId,
        productstatusId,
        comment: comment,
      );

      result.fold(
        (failure) {
          Get.snackbar(
            'ແຈ້ງເຕືອນ (Error)',
            failure.message,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        },
        (success) {
          _refreshAllData();
          // Get.back();
          orderController.fetchOrderById(orderId);
          reviewController.fetchReviewDetail();
          showDialogSuccess(
            'ສຳເລັດ',
            'ອັບເດດສະຖານະສຳເລັດ',
            Get.context!,
            showConfirmBtn: true,
            btnConfirm: 'ຕົກລົງ',
            onConfirm: () {
              Get.back();
            },
          );
        },
      );
    } catch (e) {
      // กันเหนียว กรณี Code พัง
      Get.snackbar('Error', e.toString());
    }
  }

  void _refreshAllData() async {
    // 1. รีเฟรชข้อมูลใน Controller นี้
    await fetchAcceptProduct();
    await fetchOrderProduct();

    // 2. รีเฟรชข้อมูลใน OrderController (ฝั่ง User/Transaction)
    // ใช้ Get.isRegistered เช็คก่อนเพื่อป้องกัน Error หา Controller ไม่เจอ
    if (Get.isRegistered<OrderController>()) {
      final orderCtrl = Get.find<OrderController>();
      await orderCtrl.fetchOrderProcess();
      await orderCtrl.fetchOrderCancel();
      await orderCtrl.fetchOrders();
    }
  }

  // Future<void> cancelOrder(int orderId, int productstatusId){}

  @override
  Future<void> refresh() async {
    await fetchOrderProduct();
    await fetchAcceptProduct();
  }
}
