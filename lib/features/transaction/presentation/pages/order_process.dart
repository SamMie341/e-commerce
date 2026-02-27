import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/format_color_status.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:e_commerce/features/transaction/presentation/widgets/card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProcessPage extends StatefulWidget {
  const OrderProcessPage({super.key});

  @override
  State<OrderProcessPage> createState() => _OrderProcessPageState();
}

class _OrderProcessPageState extends State<OrderProcessPage> {
  final controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: RefreshIndicator(
          onRefresh: () => controller.fetchOrderProcess(),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(color: primaryColor));
            }
            if (controller.orderProcessList.isEmpty) {
              return ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: Get.height * 0.35),
                    Text(
                      'ບໍ່ມີລາຍການດຳເນີນການ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.orderProcessList.length,
              itemBuilder: (context, index) {
                final item = controller.orderProcessList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                        item.currentStatusId == 3 ? '/payment' : '/orderDetail',
                        arguments: item.currentStatusId == 3
                            ? {'orderId': item.id}
                            : {'orderId': item.id, 'isSeller': false});
                  },
                  child: buildCardOrder(
                    hasButton: true,
                    orderNo: item.orderNo!,
                    date: item.createdAt!,
                    status: item.currentStatusId,
                    icon: item.currentStatusId == 5
                        ? Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.lightBlue,
                            size: 22,
                          )
                        : null,
                    grandTotal: item.grandtotalprice,
                    detailOnPressed: () {
                      Get.toNamed(
                          item.currentStatusId == 3
                              ? '/payment'
                              : '/orderDetail',
                          arguments: item.currentStatusId == 3
                              ? {'orderId': item.id}
                              : {'orderId': item.id, 'isSeller': false});
                    },
                    textButton:
                        item.currentStatusId == 3 ? 'ຊຳລະເງິນ' : 'ລາຍລະອຽດ',
                    textStyle: TextStyle(
                        color: FormatColorStatus.formatStatusColor(
                            item.currentStatusId!),
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            );
          }),
        ));
  }
}
