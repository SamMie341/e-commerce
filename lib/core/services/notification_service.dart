// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// // ฟังก์ชันจัดการ Background (ต้องอยู่ระดับ Top-level function คืออยู่นอก Class)
// @pragma('vm:entry-point')
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Background Title: ${message.notification?.title}');
// }

// class NotificationService {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   final _localNotifications = FlutterLocalNotificationsPlugin();

//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.max,
//   );

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       provisional: false,
//     );

//     final fCMToken = await _firebaseMessaging.getToken();
//     print('FCM Token: $fCMToken');

//     await _initLocalNotifications();

//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final notification = message.notification;
//       final android = message.notification?.android;

//       if (notification != null && android != null) {
//         _localNotifications.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               _androidChannel.id,
//               _androidChannel.name,
//               channelDescription: _androidChannel.description,
//               icon: '@mipmap/ic_launcher',
//               importance: Importance.max,
//               priority: Priority.high,
//               playSound: true,
//             ),
//           ),
//           payload: message.data.toString(),
//         );
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       Get.toNamed('/orders');
//     });

//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         Future.delayed(Duration(seconds: 1), () {
//           Get.toNamed('/orders');
//         });
//       }
//     });
//   }

//   Future<void> _initLocalNotifications() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android);

//     await _localNotifications.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         Get.toNamed('/orders');
//       },
//     );

//     final platform = _localNotifications.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }
// }
