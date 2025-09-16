import 'package:e_commerce/core/navigate/app_route.dart';
import 'package:e_commerce/core/utils/utility.dart';
// import 'package:e_commerce/core/services/cache_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Utility.initSharedPrefs();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final rememberMe = prefs.getBool('rememberMe') ?? false;
  // Get.put(CartController());

  runApp(GetMaterialApp(
    theme: ThemeData(
      fontFamily: 'NotoSansLao',
      checkboxTheme: CheckboxThemeData(
        visualDensity: VisualDensity.compact,
        splashRadius: 40,
      ),
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: (token != null && rememberMe) ? '/bottom' : '/login',
    // initialRoute: '/login',
    getPages: appRoutes(),
  ));
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
  // CacheService.clearCache();
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
