import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

showDialogSuccess(
  String title,
  String text,
  BuildContext context, {
  String? btnConfirm,
  String? btnCancel,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Duration? autoClose,
  bool? showConfirmBtn,
  bool? showCancelBtn,
  Widget? widget,
  TextAlign? textAlignment,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    animType: QuickAlertAnimType.scale,
    title: title,
    text: text,
    textAlignment: textAlignment,
    widget: widget,
    confirmBtnTextStyle: TextStyle(fontSize: 14, color: Colors.white),
    cancelBtnTextStyle: TextStyle(color: Colors.red, fontSize: 14),
    confirmBtnColor: primaryColor,
    showConfirmBtn: showConfirmBtn ?? false,
    showCancelBtn: showCancelBtn ?? false,
    confirmBtnText: btnConfirm ?? '',
    onConfirmBtnTap: onConfirm,
    cancelBtnText: btnCancel ?? '',
    onCancelBtnTap: onCancel,
    autoCloseDuration: autoClose,
  );
}

showDialogQuestion(
  String title,
  String text,
  BuildContext context, {
  String? btnConfirm,
  String? btnCancel,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Duration? autoClose,
  Widget? widget,
  TextAlign? textAlignment,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    animType: QuickAlertAnimType.scale,
    title: title,
    text: text,
    textAlignment: textAlignment,
    widget: widget,
    confirmBtnTextStyle: TextStyle(fontSize: 14, color: Colors.white),
    cancelBtnTextStyle: TextStyle(color: Colors.red, fontSize: 14),
    confirmBtnColor: primaryColor,
    showCancelBtn: true,
    confirmBtnText: btnConfirm ?? '',
    onConfirmBtnTap: onConfirm,
    cancelBtnText: btnCancel ?? '',
    onCancelBtnTap: onCancel,
    autoCloseDuration: autoClose,
  );
}

showDialogError(
  String title,
  String text,
  BuildContext context, {
  required Duration duration,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    animType: QuickAlertAnimType.slideInUp,
    title: title,
    text: text,
    showConfirmBtn: false,
    showCancelBtn: true,
    onCancelBtnTap: () => Get.back(),
    cancelBtnText: 'ລອງອີກຄັ້ງ',
    cancelBtnTextStyle: TextStyle(color: Colors.black),
    autoCloseDuration: duration,
  );
}

showScaffoldSuccess(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.greenAccent,
      content: Text(content),
    ),
  );
}
