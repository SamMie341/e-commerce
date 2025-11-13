import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
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
      backgroundColor: HexColor('f4f4f4'),
      body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async {
            controller.fetchOrderCancel();
          },
          child: StreamBuilder(
              stream: controller.fetchOrderCancel(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(color: primaryColor));
                }
                if (snapshot.hasError) {
                  return Text('ຜິດພາດ ${snapshot.error}');
                }

                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                        child: Text('ບໍ່ມີລາຍການສັ່ງຊື້ທີ່ຖືກຍົກເລີກ',
                            style: TextStyle(fontWeight: FontWeight.bold)));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 0),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ໄອດີສັ່ງຊື້: ${item.orderNo}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          item.currentStatus!.name!,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600),
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
                                        Text(
                                          Utility.formatLaoKip(
                                              num.parse(item.grandtotalprice!)),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red),
                                        ),
                                        Spacer(),
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
                                            onPressed: null,
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
                                        //     // const PopupMenuItem(
                                        //     //   value: "view",
                                        //     //   child: Text("📄 ดูรายละเอียด"),
                                        //     // ),
                                        //     // const PopupMenuItem(
                                        //     //   value: "track",
                                        //     //   child: Text("📦 ติดตามสินค้า"),
                                        //     // ),
                                        //     const PopupMenuItem(
                                        //       value: "delete",
                                        //       child: Text("❌ ລົບອໍເດີ້"),
                                        //     ),
                                        //   ],
                                        //   onSelected: (value) {
                                        //     if (value == "view") {
                                        //       print("ดูรายละเอียด");
                                        //     } else if (value == "track") {
                                        //       print("ติดตามสินค้า");
                                        //     } else if (value == "delete") {
                                        //       print('delete... ${item.id}');
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
                    ),
                  );
                }
                return Center(child: Text('ກະລຸນາລໍຖ້າ'));
              })),
    );
  }
}
