import 'dart:math';

import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/features/notification/data/model/sale_model.dart';
import 'package:flutter/material.dart';

class TopProductsChart extends StatelessWidget {
  final List<Product> products;
  const TopProductsChart({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    var sortedProducts = List<Product>.from(products);
    sortedProducts.sort((a, b) => (b.totalprice).compareTo(a.totalprice));
    var topProducts = sortedProducts.take(5).toList();
    double maxVal =
        topProducts.isNotEmpty ? (topProducts.first.totalprice.toDouble()) : 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ສິນຄ້າຂາຍດີ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ...topProducts.map((item) {
            double percent = (item.totalprice.toDouble()) / maxVal;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.title,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(Utility.formatLaoKip(item.totalprice),
                          style: TextStyle(fontSize: 12, color: Colors.blue))
                    ],
                  ),
                  SizedBox(height: 5),
                  LayoutBuilder(builder: (context, constraints) {
                    return Stack(
                      children: [
                        Container(
                          height: 10,
                          width: constraints.maxWidth,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOut,
                          height: 10,
                          width: constraints.maxWidth * percent,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                primaryColor,
                                Colors.lightBlueAccent
                              ]),
                              borderRadius: BorderRadius.circular(5)),
                        )
                      ],
                    );
                  })
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class SalesPieChart extends StatelessWidget {
  final List<Product> products;
  final double totalSales;
  const SalesPieChart(
      {super.key, required this.products, required this.totalSales});

  @override
  Widget build(BuildContext context) {
    var sorted = List<Product>.from(products);
    sorted.sort((a, b) => (b.totalprice).compareTo(a.totalprice));
    var topItems = sorted.take(4).toList();
    double topTotal =
        topItems.fold(0, (sum, item) => sum + (item.totalprice.toDouble()));
    double otherTotal = totalSales - topTotal;

    List<Color> colors = [
      Color(0xFF4C82F7),
      Color(0xFF2AC4B5),
      Color(0xFFFFB039),
      Color(0xFFFF5C5C),
      Colors.grey
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ]),
      child: Column(
        children: [
          Text('ສັດສ່ວນຂະຫຍາຍ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 150,
                    child: CustomPaint(
                      painter: _PieChartPainter(
                          topItems: topItems,
                          otherTotal: otherTotal,
                          total: totalSales,
                          colors: colors),
                    ),
                  )),
              SizedBox(width: 20),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...topItems.asMap().entries.map((e) => _buildLegend(
                          colors[e.key],
                          e.value.title,
                          '${((e.value.totalprice) / totalSales * 100).toStringAsFixed(1)}%')),
                      if (otherTotal > 0)
                        _buildLegend(colors[4], 'ອື່ນໆ',
                            '${(otherTotal / totalSales * 100).toStringAsFixed(1)}%'),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String text, String percent) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(radius: 5, backgroundColor: color),
          SizedBox(width: 8),
          Expanded(
              child: Text(text,
                  style: TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis)),
          Text(percent,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<Product> topItems;
  final double otherTotal;
  final double total;
  final List<Color> colors;

  _PieChartPainter({
    required this.topItems,
    required this.otherTotal,
    required this.total,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double startAngle = -pi / 2;

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    for (int i = 0; i < topItems.length; i++) {
      double sweepAngle =
          ((topItems[i].totalprice.toDouble()) / total) * 2 * pi;
      paint.color = colors[i];
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 15),
          startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
    if (otherTotal > 0) {
      double sweepAngle = (otherTotal / total) * 2 * pi;
      paint.color = colors[4];
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 15),
          startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
