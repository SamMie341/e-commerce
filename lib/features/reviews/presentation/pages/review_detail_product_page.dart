import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/core/widgets/star_rating_progress.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_by_product_controller.dart';
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
  final reviewByProduct = Get.find<ReviewByProductController>();
  final reviewId = Get.arguments['reviewId'];
  var rating = 5.obs;

  @override
  void initState() {
    super.initState();
    reviewByProduct.fetchReviewByPro(reviewId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: buildAppBarCustom(context, 'ຣີວິວສິນຄ້າ'),
      body: RefreshIndicator(
        onRefresh: () async {
          reviewByProduct.fetchReviewByPro(reviewId);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Obx(
              () {
                if (reviewProductController.isLoading.value) {
                  return CircularProgressIndicator(color: primaryColor);
                }
                final item = reviewProductController.reviewIdList.value;
                if (item == null) {
                  return Center(
                      child: Text('ເກີດຂໍ້ຜິດພາດ',
                          style: TextStyle(fontWeight: FontWeight.bold)));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            height: 100,
                            imageUrl: '$apiUrl/upload/product/${item.pimg}',
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_outlined, size: 100),
                          ),
                          SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(item.detail),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //     top: 10,
                          //     right: 10,
                          //   ),
                          //   child: Text(
                          //     'ສັ່ງຊື້ວັນທີ: ${Utility.formatDate(item.createdAt!)} ',
                          //     style: TextStyle(color: Colors.grey),
                          //   ),
                          // ),
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
                            Text(
                              'ໃຫ້ຄະແນນສິນຄ້າ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...List.generate(5, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // setState(() {
                                        rating.value = index + 1;
                                        // });
                                      },
                                      child: Icon(
                                        Icons.star_rounded,
                                        color: index < rating.value
                                            ? Colors.amber
                                            : Colors.grey[300],
                                        size: 28,
                                      ),
                                    );
                                  }),
                                  SizedBox(width: 10),
                                  Text('$rating ດາວ'),
                                ]),
                            SizedBox(height: 20),
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
                            Row(
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.white),
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Colors.red,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5)))),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'ຍົກເລີກ',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )),
                                SizedBox(width: 12),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: WidgetStatePropertyAll(4),
                                        shadowColor: WidgetStatePropertyAll(
                                            Colors.black),
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.blueAccent),
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Colors.blueAccent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5)))),
                                    onPressed: () {
                                      showDialogQuestion(
                                        'ຣີວິວ',
                                        'ທ່ານແນ່ໃຈທີ່ຈະຣີວິວບໍ?',
                                        context,
                                        btnConfirm: 'ຢືນຢັນ',
                                        btnCancel: 'ຍົກເລີກ',
                                        onConfirm: () {
                                          Get.back();
                                          controller.postReview(
                                            item.id,
                                            rating.value,
                                            controller.reviewController.text
                                                .trim(),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'ຢືນຢັນຣີວິວ',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            )
                          ]),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'ລາຍການທີ່ທ່ານເຄີຍຣີວິວ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Obx(() {
                      if (reviewByProduct.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        );
                      }
                      if (reviewByProduct.reviewByPro.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          child: const Text(
                            'ບໍ່ມີຣີວິວ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: reviewByProduct.reviewByPro.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final items = reviewByProduct.reviewByPro[index];
                          // final user = items.user;
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StarRatingProgress(rating: items.rating!),
                                      Row(
                                        children: [
                                          Text(
                                            Utility.formatTime(
                                                items.updatedAt!),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            Utility.formatDate(
                                                items.updatedAt!),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      )
                                    ]),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(items.comment!),
                                    Row(
                                      children: [
                                        formEdit(
                                            reviewId: items.id!,
                                            productId: items.productId!,
                                            ratingEdit: items.rating!,
                                            hintText: items.comment!,
                                            context),
                                        IconButton(
                                            onPressed: () {
                                              showDialogQuestion(
                                                'ລົບຣີວິວ',
                                                'ທ່ານແນ່ໃຈທີ່ຈະລົບຣີວິວບໍ?',
                                                context,
                                                btnConfirm: 'ຢືນຢັນ',
                                                btnCancel: 'ຍົກເລີກ',
                                                onConfirm: () {
                                                  Get.back();
                                                  reviewByProduct.deleteReview(
                                                      items.id!,
                                                      items.productId!);
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.delete_outline,
                                                color: Colors.red))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    })
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget formEdit(
    BuildContext context, {
    required int reviewId,
    required int productId,
    required int ratingEdit,
    required String hintText,
  }) {
    final editCommentController = TextEditingController();
    var rating = ratingEdit.obs;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: Get.height,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'ແກ້ໄຂຣີວິວ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Text(
                      'ຄະແນນສິນຄ້າ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () {
                        return Row(
                          children: [
                            ...List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  rating.value = index + 1;
                                },
                                child: Icon(
                                  Icons.star_rounded,
                                  color: index < rating.value
                                      ? Colors.amber
                                      : Colors.grey[300],
                                ),
                              );
                            })
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: editCommentController,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      cursorColor: Colors.grey[600],
                      maxLength: 500,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!)),
                        contentPadding: EdgeInsets.all(16),
                        counterStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.white),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5)))),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'ຍົກເລີກ',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )),
                        SizedBox(width: 12),
                        ElevatedButton(
                            style: ButtonStyle(
                                elevation: WidgetStatePropertyAll(4),
                                shadowColor:
                                    WidgetStatePropertyAll(Colors.black),
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.blueAccent),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5)))),
                            onPressed: () {
                              showDialogQuestion(
                                'ຣີວິວ',
                                'ທ່ານແນ່ໃຈທີ່ຈະແກ້ໄຂຣີວິວບໍ?',
                                context,
                                btnConfirm: 'ຢືນຢັນ',
                                btnCancel: 'ຍົກເລີກ',
                                onConfirm: () {
                                  Get.back();
                                  print(reviewId);
                                  print(productId);
                                  print(rating);
                                  print(editCommentController.text.trim());
                                  reviewByProduct.updateReview(
                                    reviewId,
                                    productId,
                                    rating.value,
                                    editCommentController.text.trim(),
                                  );
                                },
                              );
                            },
                            child: Text(
                              'ບັນທຶກ',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              );
            }).whenComplete(() {
          if (context.mounted) {
            FocusScope.of(context).unfocus();
          }
        });
      },
      child: Icon(Icons.edit_outlined),
    );
  }
}
