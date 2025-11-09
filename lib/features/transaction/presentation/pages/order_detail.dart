import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBarCustom(context, 'ລາຍລະອຽດການສັ່ງຊື້'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder<OrderDetailModel>(
            future: controller.fetchOrderById(Get.arguments['orderDetailId']),
            builder: (context, snapshot) {
              final item = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: primaryColor));
              }

              if (snapshot.hasError) {
                return Text('ຜິດພາດ: ${snapshot.error}');
              }

              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ໄອດີສັ່ງຊື້ ${item!.orderNo}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          Utility.formatDate(item.createdAt!),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          item.currentStatus!.name!,
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemCount: item.orderDetails!.length,
                      itemBuilder: (context, index) {
                        final items = item.orderDetails![index];
                        return SingleChildScrollView(
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      '$apiUrl/upload/product/${items.product!.pimg}',
                                  width: 100,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items.product!.title!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('ຈຳນວນ: ${items.quantity}'),
                                            Text(Utility.formatLaoKip(int.parse(
                                                items.price.toString()))),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Text(
                      'ຂໍ້ມູນການສັ່ງຊື້',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Table(
                      defaultColumnWidth: FixedColumnWidth(100),
                      children: [
                        TableRow(
                          children: [
                            Text(
                              'ຮ້ານຄ້າ:',
                            ),
                            Text(
                              item.shop!.name!,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'ລວມທັງໝົດ: ',
                            ),
                            Text(
                              Utility.formatLaoKip(
                                  int.parse(item.grandtotalprice!)),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                );
              }
              return const Center(child: Text('Waiting for data'));
            },
          ),
        ),
      ),
    );
  }
}
