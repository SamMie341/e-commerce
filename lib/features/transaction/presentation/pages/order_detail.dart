import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/format_color_status.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/full_image_widget.dart';
import 'package:e_commerce/core/widgets/order_timeline.dart';
import 'package:e_commerce/features/notification/presentation/controller/order_product_controller.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_detail_controller.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:e_commerce/features/transaction/presentation/widgets/check_status_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final controller = Get.find<OrderController>();
  final reviewProductController = Get.find<ReviewDetailController>();
  OrderProductController get shopController =>
      Get.find<OrderProductController>();

  @override
  void initState() {
    super.initState();
    controller.setOrderDetailFromArgs(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        toolbarHeight: Get.height * 0.08,
        backgroundColor: primaryColor,
        title: Text(
          'ລາຍລະອຽດການສັ່ງຊື້',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 5),
          child: FutureBuilder<OrderDetailModel>(
            future: controller.orderDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: primaryColor));
              }

              if (snapshot.hasError) {
                return Text('ຜິດພາດ: ${snapshot.error}');
              }

              final item = snapshot.data!;
              String? payImgName;
              final statuses = item.orderStatuses;
              if (statuses != null && statuses.isNotEmpty) {
                try {
                  final statusWithImg = statuses.firstWhere(
                      (s) => s.payimg != null && s.payimg!.isNotEmpty,
                      orElse: () => statuses.last);
                  payImgName = statusWithImg.payimg;
                } catch (e) {
                  print('Error finding image: $e');
                }
              }

              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ໄອດີສັ່ງຊື້ ${item.orderNo}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    FormatColorStatus.formatStatusText(
                                        item.currentStatusId),
                                    style: TextStyle(
                                        color:
                                            FormatColorStatus.formatStatusColor(
                                                item.currentStatusId!),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  item.currentStatusId == 5
                                      ? Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.lightBlue,
                                          size: 20,
                                        )
                                      : SizedBox.shrink()
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            '${Utility.formatDate(item.updatedAt!)} ${Utility.formatTime(item.createdAt!)}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        itemCount: item.orderDetails!.length,
                        itemBuilder: (context, index) {
                          final itemOrderDetail = item.orderDetails![index];

                          return SingleChildScrollView(
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        '$apiUrl/upload/product/${itemOrderDetail.product?.pimg ?? ''}',
                                    errorWidget: (context, url, error) {
                                      return Icon(Icons.broken_image);
                                    },
                                    width: 100,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5, right: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            itemOrderDetail.product?.title ??
                                                '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 15),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('ລາຄາ:',
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                  Text(Utility.formatLaoKip(
                                                      num.parse(itemOrderDetail
                                                          .price
                                                          .toString())))
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'ຈຳນວນ: ${itemOrderDetail.quantity}',
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                  Text(Utility.formatLaoKip(
                                                      int.parse(itemOrderDetail
                                                          .totalprice
                                                          .toString()))),
                                                ],
                                              )
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
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ຂໍ້ມູນການສັ່ງຊື້',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          controller.isSeller.value
                              ? Table(
                                  // defaultColumnWidth: FixedColumnWidth(100),
                                  children: [
                                    TableRow(
                                      children: [
                                        Text(
                                          'ຜູ້ສັ່ງຊື້:',
                                        ),
                                        Text(
                                          item.orderStatuses![0].user!
                                              .firstname!,
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
                              : Table(
                                  // defaultColumnWidth: FixedColumnWidth(100),
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
                                        Text('ເບີໂທ:'),
                                        Text(
                                          item.shop!.tel!,
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
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 10),
                          controller.isSeller.value
                              ? Builder(builder: (context) {
                                  if (payImgName == null ||
                                      payImgName.isEmpty ||
                                      item.orderStatuses?[2].comment == null) {
                                    return SizedBox.shrink();
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text('ຄຳເຫັນ',
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 18)),
                                      // TextField(
                                      //   controller:
                                      //       shopController.commentController,
                                      //   onTapOutside: (event) =>
                                      //       FocusScope.of(context).unfocus(),
                                      //   maxLength: 200,
                                      //   maxLines: 3,
                                      //   decoration: InputDecoration(
                                      //     labelText: 'ຄຳເຫັນ',
                                      //     border: OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10)),
                                      //     focusColor: primaryColor,
                                      //   ),
                                      // ),
                                      SizedBox(height: 10),
                                      Text('ສະລິປການໂອນ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            final imgUrl =
                                                '$apiPayment/$payImgName';
                                            Get.to(
                                                () => FullScreenImagePage(
                                                    imageUrl: imgUrl,
                                                    heroTag: imgUrl),
                                                opaque: false,
                                                transition: Transition.fadeIn,
                                                duration: Duration(
                                                    milliseconds: 300));
                                          },
                                          child: Hero(
                                              tag: '$apiPayment/$payImgName',
                                              child: Container(
                                                height: 500,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '$apiPayment/$payImgName',
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child: CircularProgressIndicator(
                                                                color:
                                                                    primaryColor)),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.broken_image,
                                                            color: Colors.grey,
                                                            size: 40),
                                                        Text(
                                                          'ໂຫຼດຮູບຜິດພາດ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                              : SizedBox.shrink(),
                          SizedBox(height: 20),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 20),
                          Text('ທີ່ຢູ່ຈັດສົ່ງ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(
                            'ລາຍລະອຽດການສັ່ງຊື້',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          OrderTimeline(
                            orderDetail: controller.orderDetail.value!,
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
              return const Center(child: Text('Waiting for data'));
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Obx(() {
          var order = controller.orderDetail.value;
          return checkStatusButton(
              statusId: order?.currentStatusId ?? 0,
              isShop: controller.isSeller.value,
              controller: shopController.commentController,
              onUpdateStatus: (newStatus) {
                shopController.acceptOrder(order!.id, newStatus,
                    comment: shopController.commentController.text);
                reviewProductController.fetchReviewDetail();
              },
              onGoToPayment: () {
                if (order != null) {
                  Get.toNamed('/payment', arguments: {'orderId': order.id});
                }
              });
        }),
      ),
    );
  }
}
