import 'package:flutter/material.dart';

TextFormField buildTextFormField(
    BuildContext context, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    style: TextStyle(
      fontSize: 18,
    ),
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    textInputAction: TextInputAction.next,
    cursorColor: Colors.black,
    cursorWidth: 1,
    decoration: InputDecoration(
      // filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}

TextFormField buildTextFormFieldPassword(
  BuildContext context,
  TextEditingController controller,
  VoidCallback onPressed,
  Widget icon,
  bool isShow,
) {
  return TextFormField(
    controller: controller,
    obscureText: isShow,
    obscuringCharacter: '*',
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    // textInputAction: TextInputAction.go,
    cursorColor: Colors.black,
    cursorWidth: 1,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}
