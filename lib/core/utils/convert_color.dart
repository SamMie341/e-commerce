import 'package:flutter/material.dart';

class HexColor extends Color {
  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(getColorFromHex(hexColor));
}

Color primaryColor = HexColor('#537BEC');
Color backgroundColor = HexColor('#F9F9F9');
