import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SliverAppBar buildSliverAppBarSearch(
  BuildContext context,
  Widget? title, {
  List<Widget>? actions,
}) {
  return SliverAppBar(
    flexibleSpace: Padding(
      padding: EdgeInsets.all(10),
    ),
    elevation: 5,
    floating: true,
    snap: true,
    pinned: true,
    backgroundColor: HexColor('#537BEC'),
    shadowColor: Colors.black,
    centerTitle: true,
    automaticallyImplyLeading: false,
    toolbarHeight: 70,
    title: title,
    actions: actions,
  );
}

SliverAppBar buildSliverAppBarProductDetail(BuildContext context,
    {List<Widget>? actions, String? title}) {
  return SliverAppBar(
    elevation: 5,
    floating: true,
    snap: true,
    backgroundColor: HexColor('#537BEC'),
    shadowColor: Colors.black,
    centerTitle: true,
    automaticallyImplyLeading: false,
    toolbarHeight: 70,
    title: Text(
      title ?? '',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
        )),
    actions: actions,
  );
}

AppBar buildAppBarCustom(BuildContext context, String title,
    {PreferredSizeWidget? bottom}) {
  return AppBar(
    elevation: 5,
    shadowColor: Colors.black,
    centerTitle: true,
    toolbarHeight: Get.height * 0.08,
    backgroundColor: primaryColor,
    bottom: bottom,
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        )),
    automaticallyImplyLeading: false,
    // toolbarHeight: 90,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
    ),
  );
}

AppBar buildAppBarProfile(
  BuildContext context, {
  Widget? title,
  Widget? leading,
  PreferredSizeWidget? bottom,
  List<Widget>? action,
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: primaryColor,
    leading: leading,
    elevation: 0,
    automaticallyImplyLeading: false,
    // toolbarHeight: 90,
    title: title,
    actions: action,
  );
}

AppBar buildAppBar(BuildContext? context, {String? title, Widget? leading}) {
  return AppBar(
    elevation: 3,
    toolbarHeight: 70,
    automaticallyImplyLeading: false,
    shadowColor: Colors.black,
    centerTitle: true,
    backgroundColor: HexColor('#537BEC'),
    leading: leading,
    title: Text(
      title!,
      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
    ),
  );
}
