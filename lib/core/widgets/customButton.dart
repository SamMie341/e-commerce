import 'package:flutter/material.dart';

Widget buildCustomButton({
  Color? backgroundColor,
  String? text,
  TextStyle? textStyle,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      elevation: WidgetStatePropertyAll(4),
      shadowColor: WidgetStatePropertyAll(Colors.black),
      backgroundColor: WidgetStatePropertyAll(backgroundColor),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      minimumSize: WidgetStatePropertyAll(Size(double.infinity, 56)),
    ),
    child: Center(
        child: Text(
      text!,
      style: textStyle,
    )),
  );
}
