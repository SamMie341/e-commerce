import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final controller = Get.find<ReviewDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: buildAppBarCustom(
        context,
        'ລາຍການຣີວິວ',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchReviewDetail();
        },
        child: Obx(() {
          if (controller.reviewDetailList.isEmpty) {
            return Center(
              child: Text(
                'ບໍ່ມີລາຍການຣີວິວ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            );
          }
          return Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.reviewDetailList.length,
                  itemBuilder: (_, index) {
                    final item = controller.reviewDetailList[index];
                    return Card(
                      elevation: 4,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            height: 100,
                            width: 100,
                            imageUrl:
                                '$apiUrl/upload/product/${item.product.pimg}',
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_outlined, size: 100),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       'Range: ',
                                  //       style: TextStyle(color: Colors.grey),
                                  //     ),
                                  //     Text(
                                  //       'ນ້ຳໝາກກ້ຽງ',
                                  //       style:
                                  //           TextStyle(color: Colors.grey[700]),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'ສັ່ງຊື່ວັນທີ: ${Utility.formatDate(item.createdAt)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.red),
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  onPressed: () {
                                    Get.toNamed(
                                      '/reviewProduct',
                                      arguments: {
                                        'id': item.id,
                                      },
                                    );
                                  },
                                  child: Text(
                                    'ຣີວິວ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }));
        }),
      ),
    );
  }
}
