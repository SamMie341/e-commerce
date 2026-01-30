import 'package:e_commerce/features/home/presentation/controllers/product_controller.dart';
import 'package:e_commerce/features/home/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductTab extends StatefulWidget {
  const AllProductTab({super.key});

  @override
  State<AllProductTab> createState() => _AllProductTabState();
}

class _AllProductTabState extends State<AllProductTab> {
  final controller = Get.find<ProductController>();

  final isSelected = false.obs;
  String? selectedPriceOrder;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicator();
      }
      return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.filteredProductList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 8,
            childAspectRatio: 1 / 1.50,
            mainAxisExtent: 290,
          ),
          itemBuilder: (_, index) {
            final product = controller.filteredProductList[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  print(product.id);
                },
                child: buildCardWidget(
                  context,
                  onFavoriteTap: () {
                    setState(() {
                      isSelected.value = !isSelected.value;
                    });
                  },
                  isFavorited: product.favorite.obs,
                  image: product.pimg,
                  title: product.title,
                  price: product.price,
                  location: product.category.name,
                  rating: 3,
                  // reviewCount: "3",
                ),
              ),
            );
          });
    });
  }
}
