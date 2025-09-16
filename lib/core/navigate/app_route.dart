import 'package:e_commerce/bottom_navigation_bar.dart';
import 'package:e_commerce/features/auth/presentation/bindings/AuthBinding.dart';
import 'package:e_commerce/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce/features/cart/presentation/bindings/cart_binding.dart';
import 'package:e_commerce/features/cart/presentation/pages/cart_page.dart';
import 'package:e_commerce/features/favorite/presentation/binding/favor_binding.dart';
import 'package:e_commerce/features/home/presentation/bindings/category_binding.dart';
import 'package:e_commerce/features/home/presentation/bindings/product_binding.dart';
import 'package:e_commerce/features/notification/presentation/bindings/order_product_binding.dart';
import 'package:e_commerce/features/payment/presentation/bindings/payment_binding.dart';
import 'package:e_commerce/features/payment/presentation/pages/payment_page.dart';
import 'package:e_commerce/features/product/presentation/bindings/product_by_id_binding.dart';
import 'package:e_commerce/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce/features/product/presentation/pages/product_detail.dart';
import 'package:e_commerce/features/profile/presentation/bindings/profile_binding.dart';
import 'package:e_commerce/features/notification/presentation/pages/order_product.dart';
import 'package:e_commerce/features/profile/presentation/pages/profile_page.dart';
import 'package:e_commerce/features/reviews/presentation/pages/review_page.dart';
import 'package:e_commerce/features/reviews/presentation/pages/review_product_page.dart';
import 'package:e_commerce/features/shop/presentation/pages/shop_page.dart';
import 'package:e_commerce/features/transaction/presentation/bindings/order_binding.dart';
import 'package:e_commerce/onboarding.dart';
import 'package:e_commerce/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/bottom',
        page: () => BottomBar(),
        bindings: [
          AuthBinding(),
          CategoryBinding(),
          ProductBinding(),
          ProfileBinding(),
          CartBinding(),
          OrderBinding(),
          FavorBinding(),
          OrderProductBinding(),
        ],
      ),
      GetPage(
        name: '/splash',
        page: () => SplashPage(),
      ),
      GetPage(
        name: '/onboarding',
        page: () => Onboarding(),
      ),
      GetPage(
        name: '/login',
        page: () => LoginPage(),
        binding: AuthBinding(),
      ),
      GetPage(
        name: '/home',
        page: () => HomePage(),
        bindings: [
          AuthBinding(),
          ProductBinding(),
          CartBinding(),
        ],
      ),
      GetPage(
        name: '/productDetail',
        page: () {
          final args = Get.arguments;
          return ProductDetail(
            args: args,
            key: ValueKey(
              args['id'],
            ),
          );
        },
        bindings: [
          ProductByIdBinding(),
        ],
      ),
      GetPage(
        name: '/profile',
        page: () => ProfilePage(),
        binding: AuthBinding(),
      ),
      GetPage(
        name: '/shop',
        page: () => ShopPage(),
        bindings: [
          ProfileBinding(),
          CartBinding(),
        ],
      ),
      GetPage(
        name: '/cart',
        page: () => CartPage(),
        bindings: [
          CartBinding(),
        ],
      ),
      GetPage(
        name: '/review',
        page: () => ReviewPage(),
      ),
      GetPage(
        name: '/reviewProduct',
        page: () => ReviewProductPage(),
      ),
      GetPage(
        name: '/orderProduct',
        page: () => OrderProductPage(),
        bindings: [
          ProfileBinding(),
        ],
      ),
      GetPage(
        name: '/payment',
        page: () => PaymentPage(),
        binding: PaymentBinding(),
      ),
    ];
