import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/notification/presentation/controller/shop_product_controller.dart';
import 'package:e_commerce/features/notification/presentation/widget/card_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => AllProductPageState();
}

class AllProductPageState extends State<AllProductPage> {
  final controller = Get.find<ShopProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarCustom(context, 'ສິນຄ້າທັງໝົດ'),
      body: RefreshIndicator(
          onRefresh: () async {
            controller.fetchProduct();
          },
          color: primaryColor,
          child: StreamBuilder(
              stream: controller.fetchProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('ຜິດພາດ: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                        child: Text('ບໍ່ມີລາຍການສິນຄ້າ',
                            style: TextStyle(fontWeight: FontWeight.bold)));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 10,
                      bottom: 10,
                    ),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1 / 1.50,
                          mainAxisExtent: 290,
                        ),
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          return buildCardProduct(
                              item.pimg!, item.title!, num.parse(item.price!),
                              () {
                            Get.toNamed('/', arguments: {
                              'id': item.id,
                            });
                          });
                        }),
                  );
                }
                return const Text('');
              })),
    );
  }
}
