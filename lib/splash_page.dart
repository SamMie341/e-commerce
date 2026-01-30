import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 0));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final rememberMe = prefs.getBool('rememberMe') ?? false;

    if (token != null && rememberMe) {
      Get.offAllNamed('/bottom');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
