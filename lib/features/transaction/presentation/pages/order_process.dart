import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:e_commerce/features/transaction/presentation/pages/order_detail.dart';
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
      backgroundColor: HexColor('f4f4f4'),
      body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async => await controller.refresh(),
          child: StreamBuilder(
              stream: controller.fetchOrderProcess(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                if (snapshot.hasError) return Text('ຜິດພາດ: ${snapshot.error}');
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                        child: Text('ບໍ່ມີລາຍການດຳເນີນການ',
                            style: TextStyle(fontWeight: FontWeight.bold)));
                  }
                  return Container(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),

                      shrinkWrap: true,
                      // physics: AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return Card(
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
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        Utility.formatLaoKip(
                                            num.parse(item.grandtotalprice!)),
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
                                            shadowColor: WidgetStatePropertyAll(
                                                Colors.black)),
                                        onPressed: () {
                                          Get.toNamed(
                                            '/payment',
                                            arguments: {'id': item.id},
                                          );
                                        },
                                        child: Text(
                                          'ຊຳລະເງິນ',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    // PopupMenuButton<String>(
                                    //   shadowColor: Colors.black,
                                    //   color: Colors.white,
                                    //   elevation: 10,
                                    //   itemBuilder: (context) {
                                    //     return [
                                    //       item.currentStatusId == 3
                                    //           ? const PopupMenuItem(
                                    //               value: "payment",
                                    //               child: Text("📦 ຊຳລະສິນຄ້າ"),
                                    //             )
                                    //           : const PopupMenuItem(
                                    //               child: SizedBox()),
                                    //       const PopupMenuItem(
                                    //         value: "delete",
                                    //         child: Text("❌ ລົບອໍເດີ້"),
                                    //       ),
                                    //     ];
                                    //   },
                                    //   onSelected: (value) {
                                    //     if (value == "payment") {
                                    //       Get.toNamed(
                                    //         'payment',
                                    //         arguments: {'id': item.id},
                                    //       );
                                    //     } else if (value == "track") {
                                    //     } else if (value == "delete") {
                                    //       showDialogQuestion(
                                    //         context,
                                    //         'ລົບລາຍການສັ່ງຊື້',
                                    //         'ທ່ານແນ່ໃຈບໍ?',
                                    //         () {
                                    //           controller.deleteOrder(item.id!);
                                    //           showDialogSuccess(context,
                                    //               'ສຳເລັດ', 'ລົບລາຍການສຳເລັດ');
                                    //         },
                                    //       );
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
                                    //         style:
                                    //             TextStyle(color: Colors.white),
                                    //       )),
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Text('');
              })),
    );
  }
}
