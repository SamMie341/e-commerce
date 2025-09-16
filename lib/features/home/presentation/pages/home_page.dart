import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
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

  TextEditingController searchController = TextEditingController();

  final controllerCategory = Get.find<CategoryController>();
  final controllerProduct = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  final favorController = Get.find<FavorController>();

  Future<void> refresh() async {
    await controllerCategory.fetchCategory();
    await controllerProduct.fetchProducts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      backgroundColor: HexColor('#F9F9F9'),
      body: RefreshIndicator(
        onRefresh: () async {
          // await controllerCategory.fetchCategory();
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
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                      color: Colors.white,
                    )),
                Obx(() => Stack(
                      children: [
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
                    InkWell(
                      child: Image.asset('assets/images/home_group.png'),
                    ),
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
                              'Categories',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Obx(() {
                          if (controllerCategory.isLoading.value) {
                            return Text('No data');
                          }
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: .5,
                                  color: Colors.black,
                                )),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(12),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 0.95,
                              ),
                              itemCount: controllerCategory.categoryList.length,
                              itemBuilder: (_, int index) {
                                final category =
                                    controllerCategory.categoryList[index];
                                return TextButton(
                                  onPressed: () {},
                                  iconAlignment: IconAlignment.start,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            '$apiUrl/upload/category/${category.catimg}',
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error_outline_outlined),
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
                            ),
                          );
                        }),
                        SizedBox(height: 5),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up_alt_outlined,
                                color: HexColor('#3465D8'),
                              ),
                              SizedBox(width: 5),
                              Text('ສິນຄ້າຍອດນິຍົມ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              loadMore();
                            },
                            child: Text(
                              'ເບິ່ງເພີ່ມເຕີມ',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                    Obx(() {
                      if (controllerProduct.isLoading.value) {
                        return CircularProgressIndicator();
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 5),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controllerProduct.productList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1 / 1.50,
                          mainAxisExtent: 290,
                        ),
                        itemBuilder: (_, index) {
                          final product = controllerProduct.productList[index];
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
                                    favorController
                                        .toggleFavorite(FavoriteRequest(
                                      productId: product.id,
                                      favorite: product.favorite =
                                          !product.favorite,
                                    ));
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> allProducts =
      List.generate(20, (index) => 'Product ${index + 1}');

  int itemToShow = 4;

  void loadMore() async {
    setState(() => isLoading.value = true);

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      itemToShow = (itemToShow + 4).clamp(0, allProducts.length);
      isLoading.value = false;
    });
  }
}
