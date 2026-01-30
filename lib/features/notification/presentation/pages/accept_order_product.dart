import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/format_color_status.dart';
import 'package:e_commerce/features/notification/presentation/controller/order_product_controller.dart';
import 'package:e_commerce/features/transaction/presentation/widgets/card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptOrderProductPage extends StatefulWidget {
  const AcceptOrderProductPage({super.key});

  @override
  State<AcceptOrderProductPage> createState() => _AcceptOrderProductPageState();
}

class _AcceptOrderProductPageState extends State<AcceptOrderProductPage> {
  final controller = Get.find<OrderProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: RefreshIndicator(
          onRefresh: () => controller.fetchAcceptProduct(),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(color: primaryColor));
            }
            if (controller.orderAcceptList.isEmpty) {
              return Center(
                  child: Text(
                'ບໍ່ມີລາຍການ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
            }
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: controller.orderAcceptList.length,
              itemBuilder: (context, index) {
                final item = controller.orderAcceptList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('orderDetail', arguments: {
                      'orderDetailId': item.id,
                      'isSeller': true
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
                          fontWeight: FontWeight.bold,
                          color: FormatColorStatus.formatStatusColor(
                              item.currentStatusId!)),
                      icon: item.currentStatusId == 5
                          ? Icon(
                              Icons.check_circle_outline_rounded,
                              color: Colors.lightBlue,
                              size: 20,
                            )
                          : null,
                      detailOnPressed: () {
                        Get.toNamed('/orderDetail', arguments: {
                          'orderDetailId': item.id,
                          'isSeller': true,
                        });
                      }),
                );
              },
            );
          }),
        ));
  }
}
