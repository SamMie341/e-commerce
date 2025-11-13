import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
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
        backgroundColor: HexColor('f4f4f4'),
        body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async => controller.fetchOrders(),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 0),
            child: StreamBuilder<List<OrderDetailModel>>(
                stream: controller.fetchOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(color: primaryColor));
                  }

                  if (snapshot.hasError) {
                    return Text('ຜິດພາດ: ${snapshot.error}');
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('ບໍ່ມີລາຍການສັ່ງຊື້',
                              style: TextStyle(fontWeight: FontWeight.bold)));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return Column(
                          children: [
                            Card(
                              elevation: 2,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'ໄອດີສັ່ງຊື້: ${item.orderNo}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Text(
                                              item.currentStatus!.name!,
                                              style: TextStyle(
                                                  color: HexColor('5fbe7d'),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'ລວມເປັນເງິນທັງໝົດ: ',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            Utility.formatLaoKip(num.parse(
                                                item.grandtotalprice!)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red),
                                          ),
                                        ),
                                        OutlinedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        primaryColor),
                                                elevation:
                                                    WidgetStatePropertyAll(5),
                                                shadowColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.black)),
                                            onPressed: () {
                                              Get.toNamed('/orderDetail',
                                                  arguments: {
                                                    'orderDetailId': item.id,
                                                  });
                                            },
                                            child: Text(
                                              'ລາຍລະອຽດ',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        // PopupMenuButton<String>(
                                        //   shadowColor: Colors.black,
                                        //   color: Colors.white,
                                        //   elevation: 10,
                                        //   itemBuilder: (context) => [
                                        //     const PopupMenuItem(
                                        //       value: "delete",
                                        //       child: Text("❌ ລົບອໍເດີ້"),
                                        //     ),
                                        //   ],
                                        //   onSelected: (value) {
                                        //     if (value == "view") {
                                        //     } else if (value == "track") {
                                        //     } else if (value == "delete") {
                                        //       controller.deleteOrder(item.id!);
                                        //     }
                                        //   },
                                        //   child: OutlinedButton(
                                        //       style: ButtonStyle(
                                        //           backgroundColor:
                                        //               WidgetStatePropertyAll(
                                        //                   HexColor('3465d8')),
                                        //           elevation:
                                        //               WidgetStatePropertyAll(5),
                                        //           shadowColor:
                                        //               WidgetStatePropertyAll(
                                        //                   Colors.black)),
                                        //       onPressed: null,
                                        //       child: Text(
                                        //         'ລາຍລະອຽດ',
                                        //         style: TextStyle(
                                        //             color: Colors.white),
                                        //       )),
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        );
                      },
                    );
                  }
                  return Center(child: const Text('Waiting for data'));
                }),
            // child: ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: controller.orderList.length,
            //   itemBuilder: (context, index) {
            //     final item = controller.orderList[index];
            //     return Column(
            //       children: [
            //         Card(
            //           elevation: 2,
            //           child: Container(
            //             padding: EdgeInsets.all(10),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(8),
            //             ),
            //             child: Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     Text(
            //                       'ໄອດີສັ່ງຊື້: ${item.orderNo}',
            //                       style:
            //                           TextStyle(fontWeight: FontWeight.bold),
            //                     ),
            //                     Spacer(),
            //                     Column(
            //                       children: [
            //                         Text(
            //                           item.currentStatus!.name!,
            //                           style: TextStyle(
            //                               color: HexColor('5fbe7d'),
            //                               fontWeight: FontWeight.w600),
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(height: 10),
            //                 // Row(
            //                 //   children: [
            //                 //     Text(
            //                 //       'ຈຳນວນ: ',
            //                 //       style: TextStyle(
            //                 //         color: Colors.grey,
            //                 //       ),
            //                 //     ),
            //                 //     Text('${item.quantity}'),
            //                 //   ],
            //                 // ),
            //                 // SizedBox(height: 10),
            //                 Row(
            //                   children: [
            //                     Text(
            //                       'ລວມເປັນເງິນທັງໝົດ: ',
            //                       style: TextStyle(
            //                         color: Colors.grey,
            //                       ),
            //                     ),
            //                     Text(
            //                       Utility.formatLaoKip(
            //                           num.parse(item.grandtotalprice!)),
            //                       style: TextStyle(
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.w600,
            //                           color: Colors.red),
            //                     ),
            //                     Spacer(),
            //                     PopupMenuButton<String>(
            //                       shadowColor: Colors.black,
            //                       color: Colors.white,
            //                       elevation: 10,
            //                       itemBuilder: (context) => [
            //                         const PopupMenuItem(
            //                           value: "delete",
            //                           child: Text("❌ ລົບອໍເດີ້"),
            //                         ),
            //                       ],
            //                       onSelected: (value) {
            //                         if (value == "view") {
            //                         } else if (value == "track") {
            //                         } else if (value == "delete") {
            //                           controller.deleteOrder(item.id!);
            //                         }
            //                       },
            //                       child: OutlinedButton(
            //                           style: ButtonStyle(
            //                               backgroundColor:
            //                                   WidgetStatePropertyAll(
            //                                       HexColor('3465d8')),
            //                               elevation:
            //                                   WidgetStatePropertyAll(5),
            //                               shadowColor: WidgetStatePropertyAll(
            //                                   Colors.black)),
            //                           onPressed: null,
            //                           child: Text(
            //                             'ຈັດການ',
            //                             style: TextStyle(color: Colors.white),
            //                           )),
            //                     )
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         SizedBox(height: 5),
            //       ],
            //     );
            //   },
            // ),
          ),
        ));
  }
}
