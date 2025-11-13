import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/notification/presentation/controller/order_product_controller.dart';
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
      backgroundColor: HexColor('#f4f4f4'),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchAcceptProduct();
        },
        child: Obx(() {
          if (controller.orderAcceptList.isEmpty) {
            return Center(
              child: Text(
                'ບໍ່ມີອໍເດີ້ທີ່ຮັບ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.orderAcceptList.length,
              itemBuilder: (context, index) {
                if (index == controller.orderAcceptList.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final item = controller.orderAcceptList[index];
                if (item.currentStatusId == 2) {
                  return Container();
                }
                return Card(
                  elevation: 2,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('ລວມເງີນທັງໝົດ: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: Text(
                                          Utility.formatLaoKip(
                                              num.parse(item.grandtotalprice!)),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      OutlinedButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            elevation: 5,
                                          ),
                                          child: Text('ລາຍລະອຽດ',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ))),
                                    ],
                                  )
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
        }),
      ),
    );
  }
}
