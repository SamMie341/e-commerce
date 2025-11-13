import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/notification/presentation/controller/order_product_controller.dart';
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
      backgroundColor: HexColor('#f4f4f4'),
      body: RefreshIndicator(
          onRefresh: () async => controller.fetchOrderProduct(),
          child: StreamBuilder(
              stream: controller.fetchOrderProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(color: primaryColor));
                }
                if (snapshot.hasError) return Text('ຜິດພາດ: ${snapshot.error}');
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                        child: Text('ບໍ່ມີອໍເດີ້',
                            style: TextStyle(fontWeight: FontWeight.bold)));
                  }
                  return Container(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 10,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'ໄອດີສັ່ງຊື້: ${item.orderNo}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                item.currentStatus!.name!,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                'ລວມເປັນເງິນທັງໝົດ: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  Utility.formatLaoKip(
                                                      double.parse(item
                                                          .grandtotalprice!)),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              PopupMenuButton(
                                                shadowColor: Colors.black,
                                                color: Colors.white,
                                                elevation: 5,
                                                constraints: BoxConstraints(),
                                                child: OutlinedButton(
                                                    style: TextButton.styleFrom(
                                                      elevation: 5,
                                                      backgroundColor:
                                                          primaryColor,
                                                    ),
                                                    onPressed: null,
                                                    child: Text(
                                                      'ຈັດການ',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                itemBuilder: (context) => [
                                                  const PopupMenuItem(
                                                      value: "accept",
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.done_outlined,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.green,
                                                          ),
                                                          Text('ຮັບອໍເດີ້'),
                                                        ],
                                                      )),
                                                  const PopupMenuItem(
                                                      child: Row(
                                                    children: [
                                                      Icon(Icons.clear_outlined,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                      Text('ຍົກເລີກອໍເດີ້'),
                                                    ],
                                                  ))
                                                ],
                                                onSelected: (value) {
                                                  if (value == "accept") {
                                                    controller.acceptOrder(
                                                        item.id, 3);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                return Center(child: Text('ກະລຸນາລໍຖ້າ...'));
              })),
    );
  }
}
