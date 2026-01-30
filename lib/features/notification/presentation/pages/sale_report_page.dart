import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/notification/presentation/controller/sale_report_controller.dart';
import 'package:e_commerce/features/notification/presentation/widget/sales_charts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleReportPage extends GetView<SaleReportController> {
  const SaleReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarCustom(context, 'ລາຍງານຍອດຂາຍ'),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchReport();
        },
        child: Center(
          child: Column(
            children: [
              _buildDateSelector(context),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                        child: CircularProgressIndicator(color: primaryColor));
                  }
                  if (controller.salesData.value == null) {
                    return Center(child: Text('ບໍ່ມີຂໍ້ມູນ'));
                  }
                  var data = controller.salesData.value!;
                  if (data.products == null || data.products!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_outlined,
                              size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('ບໍ່ມີຍອດຂາຍໃນຊ່ວງເວລານີ້',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                          SizedBox(height: 8),
                          Text('ລອງເລືອກວັນທີໃໝ່',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[400])),
                        ],
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildSummaryCards(data),
                        SizedBox(height: 20),
                        TopProductsChart(products: data.products ?? []),
                        SizedBox(height: 20),
                        SalesPieChart(
                          products: data.products ?? [],
                          totalSales: data.shopTotal?.toDouble() ?? 1,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.list_alt_rounded, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                                'ລາຍການສິນຄ້າທີ່ຂາຍໄດ້ (${data.products?.length ?? 0} ລາຍການ)',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.products?.length ?? 0,
                            itemBuilder: (context, index) {
                              var item = data.products![index];
                              return _buildProductCard(item);
                            })
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        onTap: () => controller.selectDateRange(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                  SizedBox(width: 10),
                  Obx(() => Text(
                        '${Utility.formatDate(controller.startDate.value)} - ${Utility.formatDate(controller.endDate.value)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
              Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(data) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
              'ຍອດຂາຍລວມ',
              Utility.formatLaoKip(data.shopTotal ?? 0),
              primaryColor,
              Icons.monetization_on_outlined),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
              'ສ່ວນແບ່ງລາຍໄດ້',
              Utility.formatLaoKip(data.shopDivide ?? 0),
              Colors.green,
              Icons.pie_chart),
        )
      ],
    );
  }

  Widget _buildInfoCard(
      String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 12)),
              Icon(icon, color: Colors.white.withOpacity(0.5), size: 18)
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _buildProductCard(item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2))
          ]),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: '$apiProductUrl/${item.pimg}',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: Icon(Icons.broken_image_rounded, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title ?? 'Unknown',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text('ລາຄາ: ${Utility.formatLaoKip(item.price ?? 0)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text('ຂາຍ: ${item.quantity} ລາຍການ',
                        style: TextStyle(fontSize: 10, color: Colors.blue)),
                  )
                ],
              )
            ],
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Utility.formatLaoKip(item.totalprice ?? 0),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                'ສ່ວນແບ່ງ: ${Utility.formatLaoKip(item.divide ?? 0)}',
                style: TextStyle(fontSize: 11, color: Colors.green),
              )
            ],
          ),
        ],
      ),
    );
  }
}
