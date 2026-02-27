import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/format_color_status.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:e_commerce/features/transaction/presentation/widgets/card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCancel extends StatefulWidget {
  const OrderCancel({super.key});

  @override
  State<OrderCancel> createState() => _OrderCancelState();
}

class _OrderCancelState extends State<OrderCancel> {
  final controller = Get.find<OrderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: RefreshIndicator(
          onRefresh: () async => await controller.fetchOrderCancel(),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(color: primaryColor));
            }
            if (controller.orderCancelList.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: Get.height * 0.35),
                  Center(
                      child: Text(
                    'ບໍ່ມີລາຍການຍົກເລີກ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.orderCancelList.length,
              itemBuilder: (context, index) {
                final item = controller.orderCancelList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/orderDetail', arguments: {
                      'orderId': item.id,
                      'isSeller': false,
                    });
                  },
                  child: buildCardOrder(
                      hasButton: true,
                      orderNo: item.orderNo!,
                      date: item.createdAt!,
                      status: item.currentStatusId,
                      grandTotal: item.grandtotalprice,
                      detailOnPressed: () {
                        Get.toNamed('/orderDetail', arguments: {
                          'orderId': item.id,
                          'isSeller': false,
                        });
                      },
                      textButton: 'ລາຍລະອຽດ',
                      textStyle: TextStyle(
                        color: FormatColorStatus.formatStatusColor(
                            item.currentStatusId),
                        fontWeight: FontWeight.bold,
                      )),
                );
              },
            );
          }),
        ));
  }
}
