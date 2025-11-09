import 'package:e_commerce/bottom_navigation_bar.dart';
import 'package:e_commerce/features/auth/presentation/bindings/AuthBinding.dart';
import 'package:e_commerce/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce/features/cart/presentation/bindings/cart_binding.dart';
import 'package:e_commerce/features/cart/presentation/pages/cart_page.dart';
import 'package:e_commerce/features/favorite/presentation/binding/favor_binding.dart';
import 'package:e_commerce/features/home/presentation/bindings/category_binding.dart';
import 'package:e_commerce/features/home/presentation/bindings/product_binding.dart';
import 'package:e_commerce/features/home/presentation/pages/category_detail.dart';
import 'package:e_commerce/features/notification/presentation/bindings/order_product_binding.dart';
import 'package:e_commerce/features/notification/presentation/bindings/shop_product_binding.dart';
import 'package:e_commerce/features/notification/presentation/pages/all_product.dart';
import 'package:e_commerce/features/notification/presentation/pages/notification_page.dart';
import 'package:e_commerce/features/payment/presentation/bindings/payment_binding.dart';
import 'package:e_commerce/features/payment/presentation/pages/payment_page.dart';
import 'package:e_commerce/features/product/presentation/bindings/product_binding.dart';
import 'package:e_commerce/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce/features/product/presentation/pages/product_detail.dart';
import 'package:e_commerce/features/profile/presentation/bindings/dropdown_binding.dart';
import 'package:e_commerce/features/profile/presentation/bindings/profile_binding.dart';
import 'package:e_commerce/features/notification/presentation/pages/order_product.dart';
import 'package:e_commerce/features/profile/presentation/pages/add_product.dart';
import 'package:e_commerce/features/profile/presentation/pages/profile_page.dart';
import 'package:e_commerce/features/reviews/presentation/bindings/review_detail_binding.dart';
import 'package:e_commerce/features/reviews/presentation/pages/review_page.dart';
import 'package:e_commerce/features/reviews/presentation/pages/review_product_page.dart';
import 'package:e_commerce/features/shop/presentation/pages/shop_page.dart';
import 'package:e_commerce/features/transaction/presentation/bindings/order_binding.dart';
import 'package:e_commerce/features/transaction/presentation/pages/order_detail.dart';
import 'package:e_commerce/onboarding.dart';
import 'package:e_commerce/splash_page.dart';
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
          ReviewDetailBinding(),
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
          return ProductDetail();
        },
        bindings: [
          ProductByIdBinding(),
        ],
      ),
      GetPage(
        name: '/profile',
        page: () => ProfilePage(),
        bindings: [
          AuthBinding(),
          ReviewDetailBinding(),
        ],
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
        binding: ReviewDetailBinding(),
      ),
      GetPage(
        name: '/reviewProduct',
        page: () => ReviewProductPage(),
        binding: ReviewDetailBinding(),
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
      GetPage(
        name: '/categoryDetail',
        page: () {
          return CategoryDetailPage();
        },
        binding: ProductBinding(),
      ),
      GetPage(
        name: '/addProduct',
        page: () => AddProductPage(),
        binding: DropdownBinding(),
      ),
      GetPage(
        name: '/orderDetail',
        page: () => OrderDetailPage(),
        binding: OrderBinding(),
      ),
      GetPage(
        name: '/orders',
        page: () => NotificationPage(),
        binding: OrderProductBinding(),
      ),
      GetPage(
        name: '/allProducts',
        page: () => AllProductPage(),
        binding: ShopProductBinding(),
      ),
    ];
