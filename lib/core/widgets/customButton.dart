import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildCustomButton({
  Color? backgroundColor,
  String? text,
  TextStyle? textStyle,
  Color? borderColor,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      fixedSize: WidgetStatePropertyAll(Size(Get.width, Get.height * 0.01)),
      elevation: WidgetStatePropertyAll(4),
      shadowColor: WidgetStatePropertyAll(primaryColor),
      backgroundColor: WidgetStatePropertyAll(backgroundColor),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: borderColor ?? Colors.transparent))),
      minimumSize: WidgetStatePropertyAll(Size(double.infinity, 56)),
    ),
    child: Center(
        child: Text(
      text ?? '',
      style: textStyle,
    )),
  );
}
