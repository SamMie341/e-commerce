import 'package:flutter/material.dart';

class CategoryProductTab extends StatefulWidget {
  const CategoryProductTab({super.key});

  @override
  State<CategoryProductTab> createState() => _CategoryProductTabState();
}

class _CategoryProductTabState extends State<CategoryProductTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildCategory('ສິນຄ້າທັງໝົດ'),
          buildCategory('ຂະໜົມອົບແຫ້ງ'),
          buildCategory('ນ້ຳໝາກໄມ້ສົດ'),
        ],
      ),
    );
  }

  Widget buildCategory(
    name,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                ),
              ],
            )),
        SizedBox(height: 5),
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey)),
        )
      ],
    );
  }
}
