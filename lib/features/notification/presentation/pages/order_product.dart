import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/format_color_status.dart';
import 'package:e_commerce/features/notification/presentation/controller/order_product_controller.dart';
import 'package:e_commerce/features/transaction/presentation/widgets/card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductPage extends StatefulWidget {
  const OrderProductPage({super.key});

  @override
  State<OrderProductPage> createState() => OrderProductPageState();
}

class OrderProductPageState extends State<OrderProductPage> {
  final controller = Get.find<OrderProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => controller.fetchOrderProduct(),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          if (controller.orderProductList.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: Get.height * 0.4),
                Center(
                    child: Text('ບໍ່ມີອໍເດີ້',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            );
          }
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.orderProductList.length,
            itemBuilder: (context, index) {
              final item = controller.orderProductList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed('orderDetail',
                      arguments: {'orderId': item.id, 'isSeller': true});
                },
                child: buildCardOrder(
                  hasButton: true,
                  orderNo: item.orderNo!,
                  status: item.currentStatusId,
                  date: item.createdAt!,
                  grandTotal: item.grandtotalprice,
                  textButton: 'ລາຍລະອຽດ',
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: FormatColorStatus.formatStatusColor(
                          item.currentStatusId)),
                  detailOnPressed: () {
                    Get.toNamed('orderDetail',
                        arguments: {'orderId': item.id, 'isSeller': true});
                  },
                ),
              );
              // Card(
              //   elevation: 2,
              //   child: Container(
              //     padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Expanded(
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                         'ໄອດີສັ່ງຊື້: ${item.orderNo}',
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold),
              //                       ),
              //                       Text(
              //                         item.currentStatus!.name!,
              //                         style: TextStyle(
              //                             color: Colors.green,
              //                             fontWeight: FontWeight.bold),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(height: 10),
              //                   Text(
              //                     Utility.formatDate(item.createdAt!),
              //                     style: TextStyle(color: Colors.grey),
              //                   ),
              //                   Row(
              //                     children: [
              //                       Text(
              //                         'ລວມເປັນເງິນທັງໝົດ: ',
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           Utility.formatLaoKip(double.parse(
              //                               item.grandtotalprice!)),
              //                           style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             color: Colors.red,
              //                           ),
              //                         ),
              //                       ),
              //                       PopupMenuButton(
              //                         shadowColor: Colors.black,
              //                         color: Colors.white,
              //                         elevation: 5,
              //                         constraints: BoxConstraints(),
              //                         child: OutlinedButton(
              //                             style: TextButton.styleFrom(
              //                               elevation: 5,
              //                               backgroundColor: primaryColor,
              //                             ),
              //                             onPressed: null,
              //                             child: Text(
              //                               'ຈັດການ',
              //                               style:
              //                                   TextStyle(color: Colors.white),
              //                             )),
              //                         itemBuilder: (context) => [
              //                           const PopupMenuItem(
              //                               value: "accept",
              //                               child: Row(
              //                                 children: [
              //                                   Icon(
              //                                     Icons.done_outlined,
              //                                     fontWeight: FontWeight.bold,
              //                                     color: Colors.green,
              //                                   ),
              //                                   Text('ຮັບອໍເດີ້'),
              //                                 ],
              //                               )),
              //                           const PopupMenuItem(
              //                               value: "cancel",
              //                               child: Row(
              //                                 children: [
              //                                   Icon(Icons.clear_outlined,
              //                                       fontWeight: FontWeight.bold,
              //                                       color: Colors.red),
              //                                   Text('ຍົກເລີກອໍເດີ້'),
              //                                 ],
              //                               )),
              //                           const PopupMenuItem(
              //                               value: "detail",
              //                               child: Row(
              //                                 children: [
              //                                   Icon(Icons.more_vert),
              //                                   Text('ລາຍລະອຽດ'),
              //                                 ],
              //                               ))
              //                         ],
              //                         onSelected: (value) {
              //                           if (value == "accept") {
              //                             controller.acceptOrder(item.id, 3);
              //                           } else if (value == "cancel") {
              //                             showDialogSuccess(
              //                               'ຍົກເລີກອໍເດີ້',
              //                               'ທ່ານຍັງສືບຕໍ່ຍົກເລີກອໍເດີ້ບໍ?',
              //                               context,
              //                               showConfirmBtn: true,
              //                               showCancelBtn: true,
              //                               btnConfirm: 'ຢືນຢັນ',
              //                               btnCancel: 'ຍົກເລີກ',
              //                               onConfirm: () {
              //                                 controller.acceptOrder(
              //                                     item.id, 2);
              //                               },
              //                               onCancel: () {
              //                                 Get.back();
              //                               },
              //                             );
              //                           } else if (value == 'detail') {
              //                             Get.toNamed('orderDetail',
              //                                 arguments: {
              //                                   'orderDetailId': item.id,
              //                                   'isSeller': true
              //                                 });
              //                           }
              //                         },
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // );
            },
          );
        }),
      ),
    );
  }
}
