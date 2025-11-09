import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
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
        onRefresh: () async {
          await controller.fetchOrderProduct();
          setState(() {});
        },
        child: Obx(() {
          if (controller.orderProductList.isEmpty) {
            return Center(
              child: Text(
                'ບໍ່ມີອໍເດີ້',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              // top: 10,
              bottom: 5,
            ),
            child: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.orderProductList.length +
                  (controller.hasMore.value && controller.isLoadingMore.value
                      ? 1
                      : 0),
              itemBuilder: (context, index) {
                if (index == controller.orderProductList.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final item = controller.orderProductList[index];
                return Card(
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      if (controller.expandedIndex.value == index) {
                        controller.expandedIndex.value = -1;
                      } else {
                        controller.expandedIndex.value = index;
                      }
                    },
                    child: Container(
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
                              CachedNetworkImage(
                                  height: 80,
                                  width: 80,
                                  imageUrl:
                                      '$apiUrl/upload/product/${item.product.pimg}'),
                              SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'ໄອດີສັ່ງຊື້: ${item.orderNo}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              if (controller
                                                      .expandedIndex.value ==
                                                  index) {
                                                controller.expandedIndex.value =
                                                    -1;
                                              } else {
                                                controller.expandedIndex.value =
                                                    index;
                                              }
                                            },
                                            icon: Obx(
                                              () => Icon(
                                                controller.expandedIndex
                                                            .value ==
                                                        index
                                                    ? Icons
                                                        .keyboard_arrow_up_rounded
                                                    : Icons
                                                        .keyboard_arrow_down_rounded,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        item.product.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            'ຈຳນວນ: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Expanded(
                                              child: Text('${item.quantity}')),
                                          Text(
                                            item.orderDetails.last.productstatus
                                                .name,
                                            style: TextStyle(
                                                color: HexColor('5fbe7d'),
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
                                          Spacer(),
                                          Text(
                                            textAlign: TextAlign.end,
                                            Utility.formatLaoKip(
                                                double.parse(item.totalprice)),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => AnimatedSize(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOutSine,
                                child: controller.expandedIndex.value == index
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'ລາຍລະອຽດຜູ້ຊື້: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      // color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuButton<String>(
                                                  shadowColor: Colors.black,
                                                  color: Colors.white,
                                                  elevation: 10,
                                                  itemBuilder: (context) => [
                                                    const PopupMenuItem(
                                                      value: 'accept',
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.check_rounded,
                                                            color: Colors.green,
                                                          ),
                                                          Text('ຮັບຄຳສັ່ງຊື້')
                                                        ],
                                                      ),
                                                    ),
                                                    const PopupMenuItem(
                                                      value: "delete",
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.close_rounded,
                                                            color: Colors.red,
                                                          ),
                                                          Text("ຍົກເລີກອໍເດີ້")
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  onSelected: (value) {
                                                    if (value == "accept") {
                                                      print('${item.id}, ${3}');
                                                      controller.acceptOrder(
                                                        item.id,
                                                        3,
                                                      );
                                                    } else if (value ==
                                                        "track") {
                                                      print("ติดตามสินค้า");
                                                    } else if (value ==
                                                        "delete") {
                                                      print(
                                                          'delete... ${item.id}, ${2}');
                                                      controller.acceptOrder(
                                                          item.id, 2);
                                                    }
                                                  },
                                                  child: OutlinedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStatePropertyAll(
                                                                HexColor(
                                                                    '3465d8')),
                                                        elevation:
                                                            WidgetStatePropertyAll(
                                                                5),
                                                        shadowColor:
                                                            WidgetStatePropertyAll(
                                                                Colors.black)),
                                                    onPressed: null,
                                                    child: Text(
                                                      'ຈັດການ',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  'ຊື່ ແລະ ນາມສະກຸນ: ',
                                                ),
                                                Text(
                                                  '${item.user.firstname} ${item.user.lastname}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'ເບີໂທ: ',
                                                ),
                                                Text(
                                                  item.user.tel,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'ໜ່ວຍ: ',
                                                ),
                                                Text(
                                                  item.user.unit.name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink()),
                          )
                        ],
                      ),
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
