import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/features/favorite/presentation/controller/favor_controller.dart';
import 'package:e_commerce/features/favorite/presentation/pages/favorite_page.dart';
import 'package:e_commerce/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce/features/notification/presentation/controller/order_product_controller.dart';
import 'package:e_commerce/features/notification/presentation/pages/notification_page.dart';
import 'package:e_commerce/features/profile/presentation/pages/profile_page.dart';
import 'package:e_commerce/features/transaction/presentation/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  final GlobalKey<HomePageState> homeKey = GlobalKey();
  final GlobalKey<FavoritePageState> favoriteKey = GlobalKey();
  final GlobalKey<TransactionPageState> transactionKey = GlobalKey();
  final GlobalKey<NotificationPageState> notificationKey = GlobalKey();
  final GlobalKey<ProfilePageState> profileKey = GlobalKey();

  final favorController = Get.find<FavorController>();
  final orderProductController = Get.find<OrderProductController>();

  void onItemTapped(int index) {
    if (selectedIndex == index) {
      switch (index) {
        case 0:
          homeKey.currentState?.refresh();
          break;
        case 1:
          favoriteKey.currentState?.controller.fetchFavor();
          break;
        case 2:
          transactionKey.currentState?.refresh();
          break;
        case 3:
          notificationKey.currentState?.controller.refresh();
          break;
        case 4:
          profileKey.currentState?.controller.fetchProfile();
        default:
      }
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: IndexedStack(
        index: selectedIndex,
        children: [
          HomePage(key: homeKey),
          FavoritePage(key: favoriteKey),
          TransactionPage(key: transactionKey),
          NotificationPage(key: notificationKey),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(0),
        height: 90,
        child: BottomNavigationBar(
          elevation: 3,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(color: Colors.white),
          iconSize: 26,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: HexColor('#537BEC'),
          onTap: onItemTapped,
          items: [
            BottomNavigationBarItem(
                label: 'ໜ້າຫຼັກ',
                // backgroundColor: HexColor('#537BEC'),
                icon: Icon(
                  Icons.home_outlined,
                  // color: Colors.white,
                ),
                activeIcon: Icon(Icons.home_rounded)),
            BottomNavigationBarItem(
              label: 'Like',
              icon: Obx(() => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Icons.favorite_border_rounded,
                      ),
                      if (favorController.favorList.isNotEmpty)
                        Positioned(
                            right: -8,
                            top: -8,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                favorController.favorList.length.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                    ],
                  )),
              activeIcon: Icon(Icons.favorite_rounded),
            ),
            BottomNavigationBarItem(
              label: 'ທຸລະກຳ',
              icon: Icon(Icons.assignment_outlined),
              activeIcon: Icon(Icons.assignment),
            ),
            BottomNavigationBarItem(
              label: 'ແຈ້ງເຕືອນ',
              icon: Obx(() => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                      ),
                      if (orderProductController.orderProductList.isNotEmpty)
                        Positioned(
                            right: -8,
                            top: -8,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                orderProductController.orderProductList.length
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                    ],
                  )),
              activeIcon: Icon(Icons.notifications_on),
            ),
            BottomNavigationBarItem(
              label: 'ບັນຊີຜູ້ໃຊ້',
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
