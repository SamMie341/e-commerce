import 'package:flutter/material.dart';

Widget buildCustomButton({
  Color? backgroundColor,
  String? text,
  TextStyle? style,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(backgroundColor),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      minimumSize: WidgetStatePropertyAll(Size(double.infinity, 56)),
    ),
    child: Center(
        child: Text(
      text!,
      style: style,
    )),
  );
}
