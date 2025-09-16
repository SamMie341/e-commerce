import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:flutter/material.dart';

Widget buildMenuItem() {
  return Container(
    height: 200,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: .5,
          color: Colors.black,
        )),
    child: GridView(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      children: [
        menuItem('vegetable.png', 'Vegetable', '', ''),
        menuItem('clothes.png', 'Clothes', '', ''),
        menuItem('fruit.png', 'Fruit', '', ''),
        menuItem('beverage.png', 'Beverage', '', ''),
        menuItem('shoe.png', 'Shoe', '', ''),
        menuItem('food.png', 'Food', '', ''),
        menuItem('bread.png', 'Bread', '', ''),
        menuItem('other.png', 'Other', '', ''),
      ],
    ),
  );
}

menuItem(icon, title, to, checkRoute) {
  return Column(
    children: [
      Stack(
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/icons/$icon',
                // width: 20,
                height: 50,
                // fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      // const SizedBox(height: 5),
      SizedBox(
        height: 25,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: HexColor('#808080'),
            fontSize: 12,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )
    ],
  );
}
