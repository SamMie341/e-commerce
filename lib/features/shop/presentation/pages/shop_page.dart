import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/home/presentation/controllers/product_controller.dart';
import 'package:e_commerce/features/shop/presentation/pages/all_product_tab.dart';
import 'package:e_commerce/features/shop/presentation/pages/category_product_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int? selectedRating;
  final controller = Get.find<ProductController>();

  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // extendBody: true,
        // extendBodyBehindAppBar: true,
        body: CustomScrollView(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            buildAppBarShop(context),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    physics: NeverScrollableScrollPhysics(),
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.red,
                    indicatorColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'ສິນຄ້າທັງໝົດ'),
                      Tab(text: 'ໝວດໝູ່ສິນຄ້າ'),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        label: Text(
                          'ລາຄາ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        icon: Icon(
                          Icons.unfold_more_outlined,
                          color: Colors.black,
                        ),
                        iconAlignment: IconAlignment.end,
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        label: Text(
                          'Rating',
                          style: TextStyle(color: Colors.black),
                        ),
                        icon: Icon(
                          Icons.star_outline_outlined,
                          color: Colors.black,
                        ),
                        iconAlignment: IconAlignment.end,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: AllProductTab(),
                        ),
                        CategoryProductTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
