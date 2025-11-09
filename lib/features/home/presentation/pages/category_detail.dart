import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';
import 'package:e_commerce/features/favorite/presentation/controller/favor_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/category_by_id_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/product_controller.dart';
import 'package:e_commerce/features/home/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({super.key});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final controller = Get.find<CategoryByIdController>();
  final favorController = Get.find<FavorController>();
  final productController = Get.find<ProductController>();

  final isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,
          title: '',
          leading: IconButton(
              onPressed: () => Get.back(canPop: true),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Obx(() {
            if (controller.categoryList.isEmpty &&
                !controller.isLoading.value) {
              return Center(
                child: Text(
                  'ບໍ່ມີສິນຄ້າ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              controller: controller.scrollController,
              padding: const EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.categoryList.length +
                  (controller.hasMore.value && controller.isLoadingMore.value
                      ? 1
                      : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
                childAspectRatio: 1 / 1.50,
                mainAxisExtent: 290,
              ),
              itemBuilder: (context, index) {
                if (index == controller.categoryList.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final product = controller.categoryList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                      onTap: () {
                        print(product.id);
                        Get.toNamed(
                          '/productDetail',
                          arguments: {
                            'id': product.id,
                            'userCode': product.userCode
                          },
                        );
                      },
                      child: buildCardWidget(
                        context,
                        onFavoriteTap: () {
                          setState(() {
                            isSelected.value = !isSelected.value;
                          });
                          favorController.toggleFavorite(FavoriteRequest(
                            productId: product.id,
                            favorite: product.favorite = !product.favorite,
                          ));
                          productController.fetchProducts();
                        },
                        isFavorited: product.favorite.obs,
                        image: product.pimg,
                        title: product.title,
                        price: product.price,
                        location: product.user.unit.name,
                        rating: product.avgRating,
                      )),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
