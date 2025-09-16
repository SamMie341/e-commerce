import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';
import 'package:e_commerce/features/favorite/presentation/controller/favor_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/product_controller.dart';
import 'package:e_commerce/features/home/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  final controller = Get.find<FavorController>();
  final controllerProduct = Get.find<ProductController>();

  final isSelected = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F9F9F9'),
      appBar: buildAppBar(context, title: 'Favorite'),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchFavor();
          },
          child: Obx(
            () {
              if (controller.favorList.isEmpty && !controller.isLoading.value) {
                return Center(
                  child: Text(
                    'ບໍ່ມີລາຍການທີ່ມັກ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: 10,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 5),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.favorList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1 / 1.50,
                    mainAxisExtent: 290,
                  ),
                  itemBuilder: (context, index) {
                    if (index == controller.favorList.length) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final item = controller.favorList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/productDetail', arguments: {
                          'id': item.productId,
                          'userCode': item.userCode,
                        });
                      },
                      child: buildCardWidget(
                        context,
                        onFavoriteTap: () {
                          setState(() {
                            isSelected.value = !isSelected.value;
                          });

                          controller.toggleFavorite(
                            FavoriteRequest(
                              productId: item.productId,
                              favorite: item.favorite = !item.favorite,
                            ),
                          );
                          controllerProduct.fetchProducts();
                        },
                        isFavorited: item.favorite.obs,
                        image: item.product.pimg,
                        title: item.product.title,
                        price: item.product.price,
                        location: '',
                        rating: item.avgRating,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
