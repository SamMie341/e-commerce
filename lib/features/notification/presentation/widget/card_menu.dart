import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildCardMenu(IconData icon, String title, {String? route}) {
  return InkWell(
    onTap: () => Get.toNamed(route!),
    child: Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Icon(
              icon,
              size: 44,
              color: primaryColor,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
