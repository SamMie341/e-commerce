import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextFormField buildTextFormField(BuildContext context,
    TextEditingController controller, FormFieldValidator<String>? validator) {
  return TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: TextInputType.number,
    style: TextStyle(
      fontSize: 18,
    ),
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    textInputAction: TextInputAction.next,
    cursorColor: Colors.blue,
    cursorWidth: 1,
    decoration: InputDecoration(
      labelText: 'ໄອດີຜູ້ໃຊ້',
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: BorderSide(color: Colors.grey),
      // ),
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
  RxBool isShow,
  FormFieldValidator<String>? validator,
) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: isShow.value,
    obscuringCharacter: '*',
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    // textInputAction: TextInputAction.go,
    cursorColor: Colors.blue,
    cursorWidth: 1,
    decoration: InputDecoration(
      labelText: 'ລະຫັດຜ່ານ',
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: BorderSide(color: Colors.grey),
      // ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}
