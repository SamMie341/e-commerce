import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/features/favorite/presentation/pages/favorite_page.dart';
import 'package:e_commerce/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce/features/notification/presentation/pages/main_shop.dart';
import 'package:e_commerce/features/notification/presentation/pages/notification_page.dart';
import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
import 'package:e_commerce/features/profile/presentation/pages/profile_page.dart';
import 'package:e_commerce/features/transaction/presentation/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final RxInt _selectedIndex = 0.obs;
  final ProfileController profileController = Get.find<ProfileController>();
  int _lastTapTime = 0;

  final List<GlobalKey> _pageKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(), // For the optional shop page
  ];

  void _onItemTapped(int index) {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_selectedIndex.value == index && now - _lastTapTime < 500) {
      // Double tap detected
      setState(() {
        // Replace the key to force a rebuild of the page
        _pageKeys[index] = GlobalKey();
      });
    } else {
      _selectedIndex.value = index;
    }
    _lastTapTime = now;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Widget> pages = [
        HomePage(key: _pageKeys[0]),
        FavoritePage(key: _pageKeys[1]),
        TransactionPage(key: _pageKeys[2]),
        ProfilePage(key: _pageKeys[3]),
      ];

      final List<BottomNavigationBarItem> navBarItems = [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'ໜ້າຫຼັກ',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Like',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long),
          label: 'ທຸລະກຳ',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'ໂປຣໄຟລ໌',
        ),
      ];

      if (profileController.hasShop.value) {
        pages.insert(3, MainShopPage(key: _pageKeys[4]));
        navBarItems.insert(
          3,
          const BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront_rounded),
            label: 'ຮ້ານຄ້າ',
          ),
        );
      }

      if (_selectedIndex.value >= pages.length) {
        _selectedIndex.value = 0;
      }

      return Scaffold(
        body: IndexedStack(
          index: _selectedIndex.value,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primaryColor,
          items: navBarItems,
          currentIndex: _selectedIndex.value,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          iconSize: 28,
        ),
      );
    });
  }
}
