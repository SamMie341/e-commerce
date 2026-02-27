import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
import 'package:e_commerce/features/transaction/presentation/widgets/card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyHistoryPage extends StatefulWidget {
  const BuyHistoryPage({super.key});

  @override
  State<BuyHistoryPage> createState() => _BuyHistoryPageState();
}

class _BuyHistoryPageState extends State<BuyHistoryPage> {
  final controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBarCustom(context, 'ປະຫວັດການສັ່ງຊື້'),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchHistory();
        },
        child: Obx(() {
          if (controller.isLoadingHistory.value) {
            return Center(
                child: CircularProgressIndicator(color: primaryColor));
          }
          if (controller.historyList.isEmpty) {
            return ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: Get.height * 0.40),
                Center(
                    child: Text(
                  'ທ່ານຍັງບໍ່ມີປະຫວັດການສັ່ງຊື້',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: controller.historyList.length,
              itemBuilder: (context, index) {
                final item = controller.historyList[index];
                return buildCardOrder(
                    hasButton: true,
                    orderNo: item.orderNo!,
                    date: item.createdAt!,
                    status: item.currentStatusId,
                    grandTotal: item.grandtotalprice,
                    textStyle: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                    textButton: 'ລາຍລະອຽດ',
                    detailOnPressed: () {
                      Get.toNamed('/orderDetail', arguments: {
                        'orderId': item.id,
                      });
                    });
              });
        }),
      ),
    );
  }
}
