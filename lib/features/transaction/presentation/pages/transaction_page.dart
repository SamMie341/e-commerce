import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:e_commerce/features/transaction/presentation/pages/order_cancel.dart';
import 'package:e_commerce/features/transaction/presentation/pages/order_success.dart';
import 'package:e_commerce/features/transaction/presentation/pages/order_process.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int currentIndex = 0;
  final controller = Get.find<OrderController>();

  Future<void> refresh() async {
    print('refresh transaction');
    controller.fetchOrders();
    controller.fetchOrderProcess();
    controller.fetchOrderCancel();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: HexColor('#537BEC'),
        title: Text(
          'ທຸລະກຳ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: TabBar(
            padding: EdgeInsets.only(bottom: 12),
            splashBorderRadius: BorderRadius.circular(10),
            dividerColor: Colors.transparent,
            controller: tabController,
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
                child: Text(
                  'ສັ່ງຊື້ສຳເລັດ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                'ກຳລັງດຳເນີນການ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'ຍົກເລີກຄຳສັ່ງຊື້',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ]),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await controller.refresh();
          },
          child: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              OrderSuccess(),
              OrderProcessPage(),
              OrderCancel(),
            ],
          )),
    );
  }
}
