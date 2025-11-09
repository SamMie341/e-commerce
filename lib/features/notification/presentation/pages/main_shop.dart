import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/notification/presentation/widget/card_menu.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class MainShopPage extends StatelessWidget {
  const MainShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, title: 'ຮ້ານຄ້າ'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            ...itemCard(),
          ],
        ),
      ),
    );
  }

  List<Widget> itemCard() {
    return [
      buildCardMenu(
          route: '/addProduct', Icons.add_shopping_cart, 'ເພີ່ມສິນຄ້າ'),
      buildCardMenu(route: '/orders', Icons.reorder, 'ອໍເດິ້ສິນຄ້າ'),
      buildCardMenu(
          route: '/allProducts', Icons.local_mall_outlined, 'ສິນຄ້າທັງໝົດ'),
      // buildCardMenu(route: '', Icons.add_shopping_cart_outlined, 'ເພີ່ມສິນຄ້າ'),
    ];
  }
}
