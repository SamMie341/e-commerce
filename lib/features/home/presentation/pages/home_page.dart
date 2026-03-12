// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/core/widgets/custom_search_textformfield.dart';
import 'package:e_commerce/features/cart/presentation/controllers/cart_controller.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';
import 'package:e_commerce/features/favorite/presentation/controller/favor_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/category_controller.dart';
import 'package:e_commerce/features/home/presentation/controllers/product_controller.dart';
import 'package:e_commerce/features/home/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  RxBool isLoading = false.obs;
  final isSelected = false.obs;

  final controllerCategory = Get.find<CategoryController>();
  final controllerProduct = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  final favorController = Get.find<FavorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: HexColor('#F9F9F9'),
      body: RefreshIndicator(
        onRefresh: () async {
          await controllerCategory.fetchCategory();
          await controllerProduct.fetchProducts();
          setState(() {});
        },
        elevation: 5,
        color: Colors.blueAccent,
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            buildSliverAppBarSearch(
              context,
              Obx(() {
                if (controllerProduct.isSearching.value) {
                  return buildCustomSearchTextFormField(
                    context,
                    controller: controllerProduct.searchController,
                    onChanged: (value) {
                      controllerProduct.filterProduct(value);
                      controllerProduct.filterPopularProduct(value);
                    },
                  );
                } else {
                  return Text(
                    'ຕະຫຼາດອອນໄລນ໌',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                }
              }),
              actions: [
                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.camera_alt_outlined,
                //       size: 30,
                //       color: Colors.white,
                //     )),
                Obx(() => IconButton(
                    onPressed: () {
                      controllerProduct.toggleSearch();
                    },
                    icon: Icon(
                      controllerProduct.isSearching.value
                          ? Icons.close
                          : Icons.search_outlined,
                      size: 30,
                    ))),
                Obx(() => Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        if (controllerProduct.isSearching.value)
                          SizedBox.shrink()
                        else
                          IconButton(
                              onPressed: () async {
                                // final items = await Utility.getCartItems();
                                Get.toNamed('cart');
                              },
                              icon: Icon(
                                Icons.shopping_basket_outlined,
                                size: 30,
                                color: Colors.white,
                              )),
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
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                      ],
                    ))
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  // top: 10,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    InkWell(child: Image.asset('assets/images/home_group.png')),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.category_outlined,
                              color: HexColor('#3465D8'),
                            ),
                            Text(
                              'ປະເພດສິນຄ້າ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Obx(() {
                          if (controllerCategory.isLoading.value) {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: primaryColor));
                          }
                          return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(12),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 0.95,
                                  crossAxisSpacing: 10,
                                ),
                                itemCount:
                                    controllerCategory.categoryList.length,
                                itemBuilder: (_, index) {
                                  final category =
                                      controllerCategory.categoryList[index];
                                  return TextButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        '/categoryDetail',
                                        arguments: {'categoryId': category.id},
                                      );
                                    },
                                    // iconAlignment: IconAlignment.start,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CachedNetworkSVGImage(
                                          '$apiCategoryUrl/${category.catimg}',
                                          height: Get.height * .05,
                                          errorWidget: Icon(
                                              Icons.error_outline_outlined,
                                              size: 31),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          category.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: HexColor('#808080'),
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ));
                        }),
                        SizedBox(height: 5),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              color: primaryColor,
                              size: 28,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'ສິນຄ້າຍອດນິຍົມ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed('/allProductDetail',
                                  arguments: {'isPopular': true});
                            },
                            child: Text(
                              'ເບິ່ງເພີ່ມເຕີມ',
                              style: const TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                    Obx(() {
                      return GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 5),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              controllerProduct
                                          .filterProductPopularList.length >
                                      10
                                  ? 10
                                  : controllerProduct
                                      .filterProductPopularList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / 1.50,
                            mainAxisExtent: 280,
                          ),
                          itemBuilder: (context, index) {
                            final popularProduct = controllerProduct
                                .filterProductPopularList[index];

                            return GestureDetector(
                              onTap: () {
                                Get.toNamed('/productDetail', arguments: {
                                  'id': popularProduct.id,
                                  'shopId': popularProduct.shop.id,
                                });
                              },
                              child: buildCardWidget(
                                context,
                                onFavoriteTap: () {
                                  setState(() {
                                    isSelected.value = !isSelected.value;
                                  });
                                  favorController.toggleFavorite(
                                      FavoriteRequest(
                                          productId: popularProduct.id,
                                          favorite: popularProduct.favorite =
                                              !popularProduct.favorite));
                                },
                                isFavorited: popularProduct.favorite.obs,
                                image: popularProduct.pimg,
                                title: popularProduct.title,
                                detail: popularProduct.detail,
                                price: popularProduct.price,
                                location: popularProduct.shop.name,
                                rating: num.tryParse(
                                        popularProduct.avgRating.toString()) ??
                                    0,
                              ),
                            );
                          });
                    }),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_mall_outlined,
                              color: primaryColor,
                              size: 28,
                            ),
                            SizedBox(width: 5),
                            Text('ສິນຄ້າທັງໝົດ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed('/allProductDetail',
                                  arguments: {'isPopular': false});
                            },
                            child: Text(
                              'ເບິ່ງເພີ່ມເຕີມ',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                    Obx(
                      () => GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 5),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            controllerProduct.filteredProductList.length > 10
                                ? 10
                                : controllerProduct.filteredProductList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1 / 1.50,
                          mainAxisExtent: 280,
                        ),
                        itemBuilder: (context, index) {
                          final product =
                              controllerProduct.filteredProductList[index];
                          return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  '/productDetail',
                                  arguments: {
                                    'id': product.id,
                                    'shopId': product.shop.id
                                  },
                                );
                              },
                              child: buildCardWidget(
                                context,
                                onFavoriteTap: () {
                                  setState(() {
                                    isSelected.value = !isSelected.value;
                                  });
                                  favorController.toggleFavorite(
                                    FavoriteRequest(
                                      productId: product.id,
                                      favorite: product.favorite =
                                          !product.favorite,
                                    ),
                                  );
                                },
                                isFavorited: product.favorite.obs,
                                image: product.pimg,
                                title: product.title,
                                detail: product.detail,
                                price: product.price,
                                location: product.shop.name,
                                rating: num.tryParse(
                                        product.avgRating.toString()) ??
                                    0,
                              ));
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
