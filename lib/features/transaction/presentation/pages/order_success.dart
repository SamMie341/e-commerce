import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/format_color_status.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:e_commerce/features/transaction/presentation/widgets/card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  final controller = Get.find<OrderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: RefreshIndicator(
          onRefresh: () async => controller.fetchOrders(),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(color: primaryColor));
            }
            if (controller.orderSuccessList.isEmpty) {
              return ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: Get.height * 0.35),
                  Text(
                    'ບໍ່ມີລາຍການອໍເດີ້',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.orderSuccessList.length,
              itemBuilder: (context, index) {
                final item = controller.orderSuccessList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/orderDetail', arguments: {
                      'orderDetailId': item.id,
                      'isSeller': false,
                    });
                  },
                  child: buildCardOrder(
                      hasButton: true,
                      orderNo: item.orderNo!,
                      date: item.createdAt!,
                      status: item.currentStatusId,
                      grandTotal: item.grandtotalprice,
                      textButton: 'ລາຍລະອຽດ',
                      textStyle: TextStyle(
                          color: FormatColorStatus.formatStatusColor(
                              item.currentStatusId),
                          fontWeight: FontWeight.bold),
                      detailOnPressed: () {
                        Get.toNamed('/orderDetail', arguments: {
                          'orderDetailId': item.id,
                          'isSeller': false,
                        });
                      }),
                );
              },
            );
          }),
        ));
  }
}
