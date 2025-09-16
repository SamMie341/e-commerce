import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

showDialogSuccess(
  BuildContext context,
  String title,
  String text,
) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    animType: QuickAlertAnimType.slideInUp,
    title: title,
    text: text,
    showConfirmBtn: false,
    // autoCloseDuration: Duration(seconds: 5),
  );
}

showDialogError(
  BuildContext context,
  String title,
  String text,
  Duration duration,
) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    animType: QuickAlertAnimType.slideInUp,
    title: title,
    text: text,
    showConfirmBtn: false,
    autoCloseDuration: duration,
  );
}
