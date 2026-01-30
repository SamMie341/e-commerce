import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/format_color_status.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:flutter/material.dart';

Widget buildCardOrder({
  required String orderNo,
  required status,
  required DateTime date,
  Icon? icon,
  required grandTotal,
  VoidCallback? detailOnPressed,
  String? textButton,
  TextStyle? textStyle,
  bool hasButton = false,
}) {
  return Column(
    children: [
      Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'ໄອດີສັ່ງຊື້: $orderNo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Spacer(),
                  Row(
                    children: [
                      Text(
                        FormatColorStatus.formatStatusText(status),
                        style: textStyle,
                      ),
                      (icon ?? SizedBox.shrink()),
                    ],
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Text(
                Utility.formatDate(date),
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  Text(
                    'ລວມເປັນເງິນທັງໝົດ: ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Utility.formatLaoKip(num.parse(grandTotal)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                  ),
                  if (hasButton &&
                      textButton != null &&
                      detailOnPressed != null)
                    OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(primaryColor),
                            elevation: WidgetStatePropertyAll(5),
                            shadowColor: WidgetStatePropertyAll(Colors.black)),
                        onPressed: detailOnPressed,
                        child: Text(
                          textButton,
                          style: TextStyle(color: Colors.white),
                        ))
                  else
                    SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 5),
    ],
  );
}
