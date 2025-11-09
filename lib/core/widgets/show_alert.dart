import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

showDialogSuccess(String title, String text, {BuildContext? context}) {
  QuickAlert.show(
    context: context!,
    type: QuickAlertType.success,
    animType: QuickAlertAnimType.slideInUp,
    title: title,
    text: text,
    showConfirmBtn: false,
    // autoCloseDuration: Duration(seconds: 5),
  );
}

showDialogError(String title, String text, Duration duration,
    {BuildContext? context}) {
  QuickAlert.show(
    context: context!,
    type: QuickAlertType.error,
    animType: QuickAlertAnimType.slideInUp,
    title: title,
    text: text,
    showConfirmBtn: false,
    autoCloseDuration: duration,
  );
}

showDialogQuestion(
  BuildContext? context,
  String title,
  String text,
  VoidCallback btnConfirm,
) {
  QuickAlert.show(
    onConfirmBtnTap: btnConfirm,
    context: context!,
    type: QuickAlertType.confirm,
    animType: QuickAlertAnimType.slideInUp,
    showConfirmBtn: true,
    showCancelBtn: true,
    confirmBtnText: 'ຕົກລົງ',
    cancelBtnText: 'ຍົກເລີກ',
    title: title,
    text: text,
  );
}

showScaffoldSuccess(String content, {BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      backgroundColor: Colors.greenAccent,
      content: Text(content),
    ),
  );
}
