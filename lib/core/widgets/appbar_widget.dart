import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/custom_search_textformfield.dart';
import 'package:flutter/material.dart';

SliverAppBar buildSliverAppBarSearch(
  BuildContext context, {
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
    title: buildCustomSearchTextFormField(context),
    actions: actions,
  );
}

SliverAppBar buildSliverAppBarProductDetail(BuildContext context,
    {List<Widget>? actions}) {
  return SliverAppBar(
    elevation: 3,
    floating: true,
    snap: true,
    backgroundColor: HexColor('#537BEC'),
    shadowColor: Colors.black,
    centerTitle: true,
    automaticallyImplyLeading: false,
    toolbarHeight: 70,
    title: buildCustomSearchTextFormField(context),
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
    {Widget? leading, PreferredSizeWidget? bottom}) {
  return AppBar(
    elevation: 5,
    shadowColor: Colors.black,
    centerTitle: true,
    backgroundColor: HexColor('#537BEC'),
    bottom: bottom,
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
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
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: HexColor('#537BEC'),
    leading: leading,
    automaticallyImplyLeading: false,
    // toolbarHeight: 90,
    title: title,
  );
}

SliverAppBar buildAppBarShop(BuildContext context, {VoidCallback? onPressed}) {
  return SliverAppBar(
    expandedHeight: 200,
    automaticallyImplyLeading: false,
    floating: true,
    snap: true,
    stretch: true,
    flexibleSpace: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/shop.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    ),
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        )),
    title: TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white30,
          hintText: 'ຄົ້ນຫາລາຍການສິນຄ້າ ຫຼື ຮ້ານຄ້າ ທີ່ທ່ານຕ້ອງການ',
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.search_outlined),
          prefixIconColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ))),
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
            size: 28,
          )),
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
            size: 28,
          )),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 10,
          bottom: 15,
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/juice.jpg',
                        width: 50,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ຮ້ານຂາຍນ້ຳໝາກໄມ້ >',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '1000 ຜູ້ຕິດຕາມ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25)),
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(8))),
                        ),
                        child: Text(
                          'ຕິດຕາມ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 0.5,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                      Text(
                        'ຢັ້ງຢືນໂດຍຫ້ອງການໄຟຟ້າລາວ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      Text(
                        'ຮັບປະກັນສິນຄ້າ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
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
