import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';
import 'package:e_commerce/features/favorite/presentation/controller/favor_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/product_controller.dart';
import 'package:e_commerce/features/home/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductDetail extends StatefulWidget {
  const AllProductDetail({super.key});

  @override
  State<AllProductDetail> createState() => _AllProductDetailState();
}

class _AllProductDetailState extends State<AllProductDetail> {
  final controllerProduct = Get.find<ProductController>();
  final favorController = Get.find<FavorController>();
  late bool isPopular;

  @override
  void initState() {
    super.initState();
    isPopular = Get.arguments?['isPopular'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F9F9F9'),
      appBar: buildAppBarCustom(
          context, isPopular ? 'ສິນຄ້າຍອດນິຍົມທັງໝົດ' : 'ສິນຄ້າທັງໝົດ'),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Obx(() {
          final productList = isPopular
              ? controllerProduct.filterProductPopularList
              : controllerProduct.filteredProductList;

          if (productList.isEmpty) {
            return ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: Get.height * 0.38),
                Center(
                    child: Text(
                  'ບໍ່ມີສິນຄ້າ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 1.50,
              mainAxisExtent: 280,
            ),
            itemBuilder: (context, index) {
              final product = productList[index];

              return GestureDetector(
                onTap: () {
                  Get.toNamed('/productDetail', arguments: {
                    'id': product.id,
                    'shopId': product.shop.id,
                  });
                },
                child: buildCardWidget(
                  context,
                  onFavoriteTap: () {
                    // Update favorite state locally to give immediate feedback
                    setState(() {
                      product.favorite = !product.favorite;
                    });
                    favorController.toggleFavorite(FavoriteRequest(
                      productId: product.id,
                      favorite: product.favorite,
                    ));
                  },
                  isFavorited: product.favorite.obs,
                  image: product.pimg,
                  title: product.title,
                  detail: product.detail,
                  price: product.price,
                  location: product.shop.name,
                  rating: num.tryParse(product.avgRating.toString()) ?? 0,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
