import 'package:e_commerce/features/payment/presentation/bindings/payment_binding.dart';
import 'package:e_commerce/features/payment/presentation/pages/payment_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class FcmService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token this device: $fcmToken');
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleMessageAction(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageAction);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('get notification in app: ${message.notification?.title}');
      if (message.notification != null) {
        Get.snackbar(
          message.notification!.title ?? 'ແຈ້ງເຕືອນໃໝ່',
          message.notification!.body ?? '',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 4),
        );
      }
    });
  }

  static void handleMessageAction(RemoteMessage message) {
    print(message.data);
    // Add small delay to ensure GetMaterialApp is ready (especially on cold start)
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   if (message.data.isNotEmpty) {
    //     final orderIdRaw = message.data['orderId'];

    //     if (orderIdRaw != null) {
    //       final int orderId = int.tryParse(orderIdRaw.toString()) ?? 0;
    //       // final int statusId = int.tryParse(statusIdRaw?.toString() ?? '') ?? 0;

    //       // Status roles mapping
    //       // Seller: 1, 4, 7
    //       // Buyer: 3, 5, 6
    //       // Both: 2 (defaults to buyer for navigation context)

    //       var statusId;

    //       if (statusId == 3) {
    //         // Waiting for payment -> Go to Payment page
    //         Get.to(
    //           () => PaymentPage(),
    //           binding: PaymentBinding(),
    //           arguments: {'orderId': orderId},
    //         );
    //       } else {
    //         // Seller role for 1, 4, 7 as requested
    //         bool isSeller = [1, 4, 7].contains(statusId);

    //         Get.toNamed('/orderDetail', arguments: {
    //           'orderId': orderId,
    //           'isSeller': isSeller,
    //           // 'statusId': statusId,
    //         });
    //       }
    //     }
    //   }
    // });
  }
}
