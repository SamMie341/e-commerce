import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/star_rating_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildCardWidget(
  BuildContext context, {
  RxBool? isFavorited,
  image,
  title,
  rating,
  price,
  location,
  // reviewCount,
  VoidCallback? onFavoriteTap,
}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  // height: 120,
                  // width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage('$apiProductUrl/$image'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          )
                        ]),
                    child: Obx(
                      () => IconButton(
                        onPressed: onFavoriteTap,
                        icon: Icon(
                          isFavorited!.value
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: isFavorited.value ? Colors.red : Colors.black,
                          size: 18,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    )),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Text(
                  Utility.formatLaoKip(price),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE53E3E),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          Expanded(
                            child: Text(
                              location,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    StarRatingProgress(
                      rating: rating,
                      size: 14,
                      spacing: 0,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
