import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static const String cartKey = 'cart_items';
  static const String userCode = 'code';

  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 1,
    colors: true,
    printEmojis: true,
    printTime: false,
  ));

  static SharedPreferences? preferences;
  static Future initSharedPrefs() async =>
      preferences = await SharedPreferences.getInstance();

  static dynamic getSharedPreference(String key) {
    if (preferences == null) return null;
    return preferences!.get(key);
  }

  static Future<bool> setSharedPreference(String key, dynamic value) async {
    if (preferences == null) return false;
    if (value is String) return await preferences!.setString(key, value);
    if (value is int) return await preferences!.setInt(key, value);
    if (value is bool) return await preferences!.setBool(key, value);
    if (value is double) return await preferences!.setDouble(key, value);
    return false;
  }

  static Future<bool> removeSharedPreference(String key) async {
    if (preferences == null) return false;
    return await preferences!.remove(key);
  }

  static Future<bool> clearSharedPreference(String key) async {
    if (preferences == null) return false;
    return preferences!.containsKey(key);
  }

  static Future<bool> checkSharedPreference(String key) async {
    if (preferences == null) return false;
    return preferences!.containsKey(key);
  }

  static String formatLaoKip(num amount) {
    final formatter = NumberFormat('#,###', 'en_EN');
    return '${formatter.format(amount)} ₭';
  }

  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    final formatter = DateFormat(format);
    return formatter.format(date);
  }

  static showAlertDialog(context, title, content, [VoidCallback? onPressed]) {
    AlertDialog buildAlertDialog(Color backgroundColor, IconData icon) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(15),
        )),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 35,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            Text(
              content,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
                onPressed: onPressed ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: Text(
                  'ຕົກລົງ',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                )),
          )
        ],
      );
    }

    switch (title) {
      case 'ok':
        return showDialog(
            context: context,
            builder: (BuildContext context) => FractionallySizedBox(
                heightFactor: 0.33,
                child: buildAlertDialog(Colors.green[700]!, Icons.check)));
      case 'error':
        return showDialog(
            context: context,
            builder: (BuildContext context) => FractionallySizedBox(
                heightFactor: 0.33,
                child: buildAlertDialog(Colors.red[700]!, Icons.close)));
      case 'warning':
        return showDialog(
            context: context,
            builder: (BuildContext context) => FractionallySizedBox(
                heightFactor: 0.33,
                child: buildAlertDialog(Colors.orange[700]!, Icons.warning)));
      default:
        return showDialog(
            context: context,
            builder: (BuildContext context) => FractionallySizedBox(
                heightFactor: 0.33,
                child:
                    buildAlertDialog(Colors.blue[700]!, Icons.info_outline)));
    }
  }

  static Future<void> addToCart(Map<String, dynamic> product) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(cartKey);
    List<Map<String, dynamic>> cart = [];
    if (cartJson != null) {
      cart = List<Map<String, dynamic>>.from(json.decode(cartJson));
    }

    final index = cart.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      cart[index]['quantity'] = (cart[index]['quantity'] ?? 1) + 1;
    } else {
      cart.add({...product, 'quantity': 1});
    }
    await prefs.setString(cartKey, json.encode(cart));
  }

  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(cartKey);
    if (cartJson == null) return [];
    return List<Map<String, dynamic>>.from(json.decode(cartJson));
  }

  static Future<void> removeItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getCartItems();
    if (index < items.length) {
      items.removeAt(index);
      await prefs.setString(cartKey, json.encode(items));
    }
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }

  static Future<int> getCartCount() async {
    final items = await getCartItems();
    return items.length;
  }

  static Future<void> removeFromCart(Map<String, dynamic> product) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(cartKey);
    List<Map<String, dynamic>> cart = [];

    if (cartJson != null) {
      cart = List<Map<String, dynamic>>.from(json.decode(cartJson));
    }

    final index = cart.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      if (cart[index]['quantity'] > 1) {
        cart[index]['quantity']--;
      } else {
        cart.removeAt(index);
      }
    }
    await prefs.setString(cartKey, json.encode(cart));
  }
}
