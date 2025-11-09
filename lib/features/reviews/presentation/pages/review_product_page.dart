import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_detail_controller.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewProductPage extends StatefulWidget {
  const ReviewProductPage({super.key});

  @override
  State<ReviewProductPage> createState() => _ReviewProductPageState();
}

class _ReviewProductPageState extends State<ReviewProductPage> {
  final controller = Get.find<ReviewDetailController>();
  final reviewProductController = Get.find<ReviewProductController>();
  int rating = 5;

  final List<String> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: buildAppBarCustom(context, 'ຣີວິວສິນຄ້າ'),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Obx(() {
              if (reviewProductController.isLoading.value ||
                  reviewProductController.reviewIdList.isEmpty) {
                CircularProgressIndicator();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviewProductController.reviewIdList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = reviewProductController.reviewIdList.first;
                    return Column(
                      children: [
                        Card(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                height: 100,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                                      // SizedBox(height: 10),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'Range: ',
                                      //       style: TextStyle(color: Colors.grey),
                                      //     ),
                                      //     Text(
                                      //       'ນ້ຳໝາກກ້ຽງ',
                                      //       style: TextStyle(
                                      //           color: Colors.grey[700]),
                                      //     ),
                                      //     Spacer(),
                                      //     Padding(
                                      //       padding:
                                      //           const EdgeInsets.only(right: 10),
                                      //       child: Text(
                                      //         'ສັ່ງຊື້ວັນທີ: ${Utility.formatDate(item.createdAt)}',
                                      //         style:
                                      //             TextStyle(color: Colors.grey),
                                      //       ),
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
                                child: Text(
                                  'ສັ່ງຊື້ວັນທີ: ${Utility.formatDate(item.createdAt)}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ...List.generate(5, (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              rating = index + 1;
                                            });
                                          },
                                          child: Icon(
                                            Icons.star_rounded,
                                            color: index < rating
                                                ? Colors.amber
                                                : Colors.grey[300],
                                            size: 28,
                                          ),
                                        );
                                      }),
                                      SizedBox(width: 10),
                                      Text('$rating ດາວ'),
                                    ]),
                                SizedBox(height: 10),
                                Text(
                                  'ຄຳອະທິບາຍສິນຄ້າ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[300]!, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextField(
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    controller: controller.reviewController,
                                    cursorColor: Colors.grey[600],
                                    maxLength: 500,
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                      hintText: 'ປ້ອນຄຳອະທິບາຍສິນຄ້າ......',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(16),
                                      counterStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                // Text(
                                //   'ອັບໂຫຼດຮູບພາບ',
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.w600,
                                //     color: Colors.black87,
                                //   ),
                                // ),
                                // SizedBox(height: 12),
                                // Row(
                                //   children: [
                                //     // Upload Area
                                //     Expanded(
                                //       flex: 2,
                                //       child: GestureDetector(
                                //         onTap: _showImagePickerOptions,
                                //         child: DottedBorder(
                                //           borderType: BorderType.RRect,
                                //           radius: Radius.circular(8),
                                //           dashPattern: [8, 4],
                                //           strokeWidth: 2,
                                //           color: Colors.blue,
                                //           child: SizedBox(
                                //             height: 120,
                                //             width: double.infinity,
                                //             child: Column(
                                //               mainAxisAlignment: MainAxisAlignment.center,
                                //               children: [
                                //                 Icon(
                                //                   Icons.image,
                                //                   size: 40,
                                //                   color: Colors.blue,
                                //                 ),
                                //                 SizedBox(height: 8),
                                //                 Text(
                                //                   'ອັບໂຫຼດຮູບ',
                                //                   style: TextStyle(
                                //                     color: Colors.blue,
                                //                     fontSize: 14,
                                //                     fontWeight: FontWeight.w500,
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 12),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.white),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 0,
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)))),
                                        onPressed: () {},
                                        child: Text(
                                          'ຍົກເລີກ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        )),
                                    SizedBox(width: 12),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                WidgetStatePropertyAll(4),
                                            shadowColor: WidgetStatePropertyAll(
                                                Colors.black),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.blueAccent),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: Colors.blueAccent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)))),
                                        onPressed: () {
                                          print(item.id);
                                          print(rating);
                                          print(
                                              controller.reviewController.text);
                                          controller.postReview(
                                            item.id,
                                            rating,
                                            'Perfect',
                                          );
                                        },
                                        child: Text(
                                          'ຢືນຢັນຣີວິວ',
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                )
                              ]),
                        )
                      ],
                    );
                  });
            })),
      ),
    );
  }
}
