import 'package:e_commerce/core/controllers/network_controller.dart';
import 'package:e_commerce/core/navigate/app_route.dart';
import 'package:e_commerce/core/services/fcm_service.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:e_commerce/core/services/cache_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmService().initNotifications();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // await PermissionService().requestNotificationPermission();
  // await PermissionService().requestPhotoPermission();
  // await PermissionService().requestSavePermission();
  await Utility.initSharedPrefs();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final rememberMe = prefs.getBool('rememberMe') ?? false;
  final String? countryCode =
      WidgetsBinding.instance.platformDispatcher.locale.countryCode;
  print(countryCode);

  runApp(
    GetMaterialApp(
      onInit: () {
        Get.put<NetworkController>(NetworkController(), permanent: true);
      },
      builder: (BuildContext context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              mediaQuery.textScaleFactor.clamp(1.0, 1.0),
            ),
          ),
          child: child!,
        );
      },
      theme: ThemeData(
        appBarTheme: AppBarThemeData(
            systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        )),
        checkboxTheme: CheckboxThemeData(
          visualDensity: VisualDensity.compact,
          splashRadius: 40,
        ),
        useMaterial3: false,
        textTheme: GoogleFonts.notoSerifLaoTextTheme(),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
      ),

      debugShowCheckedModeBanner: false,
      initialRoute: (token != null && rememberMe) ? '/bottom' : '/login',
      // initialRoute: '/login',
      getPages: appRoutes(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.detached) {
  //     CacheService.clearCache();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
