import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
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
        onRefresh: () async {
          controller.fetchOrders();
        },
        child: Obx(
          () {
            if (controller.orderList.isEmpty) {
              return Center(
                child: Text(
                  'ບໍ່ມີລາຍການສັ່ງຊື້',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            }
            return Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.orderList.length,
                itemBuilder: (context, index) {
                  final item = controller.orderList[index];
                  return Column(
                    children: [
                      Card(
                        elevation: 2,
                        child: Container(
                          padding: EdgeInsets.all(10),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        item.orderDetails.last.productstatus
                                            .name,
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
                                    'ຈຳນວນ: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text('${item.quantity}'),
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
                                        num.parse(item.totalprice)),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                  Spacer(),
                                  PopupMenuButton<String>(
                                    shadowColor: Colors.black,
                                    color: Colors.white,
                                    elevation: 10,
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: "delete",
                                        child: Text("❌ ລົບອໍເດີ້"),
                                      ),
                                    ],
                                    onSelected: (value) {
                                      if (value == "view") {
                                        print("ดูรายละเอียด");
                                      } else if (value == "track") {
                                        print("ติดตามสินค้า");
                                      } else if (value == "delete") {
                                        print('delete... ${item.id}');
                                        controller.deleteOrder(item.id);
                                      }
                                    },
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    HexColor('3465d8')),
                                            elevation:
                                                WidgetStatePropertyAll(5),
                                            shadowColor: WidgetStatePropertyAll(
                                                Colors.black)),
                                        onPressed: null,
                                        child: Text(
                                          'ຈັດການ',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )
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
          },
        ),
      ),
    );
  }
}
