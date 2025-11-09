import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/features/notification/presentation/controller/order_product_controller.dart';
import 'package:e_commerce/features/notification/presentation/pages/accept_order_product.dart';
import 'package:e_commerce/features/notification/presentation/pages/order_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;
  final controller = Get.find<OrderProductController>();

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
        appBar: AppBar(
          elevation: 3,
          shadowColor: Colors.black,
          backgroundColor: HexColor('#537BEC'),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_new_outlined)),
          title: Text(
            'ອໍເດີ້ສິນຄ້າ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: tabController,
            padding: const EdgeInsets.only(bottom: 12),
            splashBorderRadius: BorderRadius.circular(10),
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.white,
            labelColor: HexColor('#537BEC'),
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            tabs: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('ຮັບອໍເດີ້'),
              ),
              Text('ອໍເດີ້ທີ່ຮັບສຳເລັດ'),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                OrderProductPage(),
                AcceptOrderProductPage(),
              ]);
        }));
  }
}
