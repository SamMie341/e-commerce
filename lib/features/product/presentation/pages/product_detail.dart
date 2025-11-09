import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/core/widgets/star_rating_progress.dart';
import 'package:e_commerce/features/cart/presentation/controllers/cart_controller.dart';
import 'package:e_commerce/features/home/presentation/widgets/card_widget.dart';
import 'package:e_commerce/features/product/presentation/controller/product_by_id_controller.dart';
import 'package:e_commerce/features/product/presentation/controller/product_by_shop_controller.dart';
import 'package:e_commerce/features/product/presentation/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final controller = Get.find<ProductByIdController>();
  final cartController = Get.find<CartController>();
  final reviewController = Get.find<ReviewController>();
  // final shopController = Get.find<ProductByShopController>();

  RxBool onSelected = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isExpanded = false.obs;
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    print('userCode: ${Get.arguments['id']}');
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(color: Colors.grey.shade600, fontSize: 16);
    final maxLines = isExpanded.value ? null : 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loadProductById(Get.arguments['id']);
          reviewController.loadReview(Get.arguments['id']);
        },
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            buildSliverAppBarProductDetail(
              context,
              actions: [
                Obx(() => Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final items = await Utility.getCartItems();
                            print(items);
                            Get.toNamed('cart');
                          },
                          icon: Icon(
                            Icons.shopping_basket_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        if (cartController.cartCount.value > 0)
                          Positioned(
                              top: 12,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  cartController.cartCount.value.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ))
                      ],
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 30,
                      color: Colors.white,
                    )),
              ],
            ),
            SliverToBoxAdapter(
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final product = controller.productDetail.value;
                  if (product == null) {
                    print('Product detail $product');
                    return SafeArea(
                      child: Center(
                        child: Text(
                          'ບໍ່ມີຂໍ້ມູນ',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          // bottom: 8,
                        ),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: '$apiUrl/upload/product/${product.pimg}',
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline_outlined),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                            ),
                          ),
                          fit: BoxFit.contain,
                          height: 300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                StarRatingProgress(
                                  rating: product.avgRating!,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Text(product.avgRating.toString())),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    Utility.formatLaoKip(
                                        product.price.toDouble()),
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        color: Colors.grey, size: 16),
                                    Text(
                                      product.user.unit.name,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'ລາຍລະອຽດສິນຄ້າ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.detail,
                                  style: defaultStyle,
                                  maxLines: maxLines,
                                  overflow: isExpanded.value
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: TextButton.icon(
                                      onPressed: () => setState(() =>
                                          isExpanded.value = !isExpanded.value),
                                      icon: Icon(isExpanded.value
                                          ? Icons.expand_less_outlined
                                          : Icons.expand_more_outlined),
                                      label: Text(isExpanded.value
                                          ? 'ຫຍໍ້'
                                          : 'ອ່ານເພີ່ມ')),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       'ສິນຄ້າຈາກຮ້ານດຽວກັນ',
                            //       style: TextStyle(
                            //         fontSize: 17,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //     TextButton(
                            //       onPressed: () {},
                            //       child: Text(
                            //         'ເບິ່ງເພີ່ມເຕີມ',
                            //         style: TextStyle(
                            //             color: Colors.blue,
                            //             fontWeight: FontWeight.w600),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Obx(() {
                            //   if (shopController.isLoading.value) {
                            //     return CircularProgressIndicator();
                            //   }
                            //   final filteredShop = shopController.shops
                            //       .where((productShop) =>
                            //           productShop.id !=
                            //           controller.productDetail.value?.id)
                            //       .toList();
                            //   return SizedBox(
                            //     height: 290,
                            //     child: GridView.builder(
                            //         scrollDirection: Axis.horizontal,
                            //         padding: const EdgeInsets.only(bottom: 10),
                            //         itemCount: filteredShop.length,
                            //         shrinkWrap: true,
                            //         physics: AlwaysScrollableScrollPhysics(),
                            //         gridDelegate:
                            //             SliverGridDelegateWithFixedCrossAxisCount(
                            //           crossAxisCount: 1,
                            //           childAspectRatio: 1 / 0.6,
                            //           mainAxisSpacing: 10,
                            //         ),
                            //         itemBuilder: (_, index) {
                            //           final productShop = filteredShop[index];
                            //           return Container(
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius: BorderRadius.circular(10),
                            //             ),
                            //             child: InkWell(
                            //               onTap: () {
                            //                 controller
                            //                     .loadProductById(productShop.id);
                            //                 reviewController
                            //                     .loadReview(productShop.id);
                            //                 // controllerProduct.fetchProducts();
                            //               },
                            //               child: buildCardWidget(
                            //                 context,
                            //                 onFavoriteTap: () {
                            //                   setState(() {
                            //                     isSelected = !isSelected;
                            //                   });
                            //                 },
                            //                 isFavorited: productShop.favorite.obs,
                            //                 image: productShop.pimg,
                            //                 title: productShop.title,
                            //                 price: productShop.price,
                            //                 location: productShop.shop.name,
                            //                 rating: productShop.avgRating,
                            //               ),
                            //             ),
                            //           );
                            //         }),
                            //   );
                            // }),
                            // SizedBox(height: 15),
                            Text(
                              'ຣີວິວສິນຄ້າ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            product.avgRating.toString(),
                                            style: TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    // Right side: Star rating bar chart
                                    Expanded(
                                      child: Column(
                                        children: product.ratingCounts!.entries
                                            .map((entry) {
                                          final star = entry.key;
                                          final count = entry.value;
                                          return _buildStarRatingBar(
                                              int.parse(star.toString()),
                                              count,
                                              int.parse(product.reviewCount
                                                  .toString()));
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${product.reviewCount.toString()} ຣີວິວ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Container(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 12, vertical: 8),
                                    //   decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.grey),
                                    //     borderRadius: BorderRadius.circular(20),
                                    //   ),
                                    //   child: Row(
                                    //     children: const [
                                    //       Text('1-5'),
                                    //       Icon(Icons.keyboard_arrow_down),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Obx(() {
                                  if (reviewController.isLoading.value) {
                                    return Center(child: Text('No Data'));
                                  }
                                  if (reviewController.reviewList.isNotEmpty) {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(0),
                                      itemCount:
                                          reviewController.reviewList.length,
                                      itemBuilder: (context, index) {
                                        final reviews =
                                            reviewController.reviewList[index];
                                        return Card(
                                          color: Colors.white,
                                          elevation: 2,
                                          shadowColor: Colors.black,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20,
                                                      child: Icon(Icons.person),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            reviews
                                                                .user.firstname,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              StarRatingProgress(
                                                                  rating: reviews
                                                                      .rating,
                                                                  size: 14),
                                                              const SizedBox(
                                                                  width: 8),
                                                              // Date
                                                              Text(
                                                                Utility.formatDate(
                                                                    reviews
                                                                        .createdAt),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                // Review text
                                                Text(
                                                  reviews.comment,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        'ບໍ່ມີຣີວິວ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 70,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 12)),
                        backgroundColor: WidgetStatePropertyAll(Colors.red),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: Text(
                        'ສັ່ງຊື້',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final product = controller.productDetail.value!.toJson();
                      if (product.isNotEmpty) {
                        cartController.addProduct(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                'ເພີ່ມ ${controller.productDetail.value!.title} ສຳເລັດ'),
                            duration: Duration(milliseconds: 1500),
                            width: 280,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                        // Get.snackbar('ເພີ່ມສິນຄ້າແລ້ວ',
                        //     '${controller.productDetail.value!.title} ຖືກເພີ່ມລົງກະຕ່າແລ້ວ');
                      }
                    },
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 12)),
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      'ເພີ່ມລົງກະຕ່າ',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildStarRatingBar(int star, int count, int total) {
    double percentage = total > 0 ? count / total : 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          ...List.generate(
            star,
            (i) => Icon(Icons.star, color: Colors.amber, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              minHeight: 8,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
