import 'package:flutter/material.dart';

Widget buildCustomSearchTextFormField(
  BuildContext context, {
  TextEditingController? controller,
  Function(String)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    autofocus: true,
    style: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    onChanged: onChanged,
    onTapOutside: (event) {
      FocusScope.of(context).unfocus();
    },
    textInputAction: TextInputAction.search,
    cursorColor: Colors.white,
    cursorWidth: 1,
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.search_outlined,
        color: Colors.white,
      ),
      hintText: 'ຄົ້ນຫາລາຍການສິນຄ້າ ຫຼື ຮ້ານຄ້າ ທີ່ທ່ານຕ້ອງການ',
      hintStyle: TextStyle(color: Colors.white),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      // focusColor: Colors.white,
      // hoverColor: Colors.white,
    ),
  );
}
