import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:flutter/material.dart';

Color _getStatusColor(num status) {
  switch (status) {
    case 1:
      return Colors.orange; // ລໍຖ້າອະນຸມັດ
    case 2:
      return Colors.green; // ອະນຸມັດແລ້ວ
    case 3:
      return Colors.red; // ປະຕິເສດ
    default:
      return Colors.grey;
  }
}

Widget buildCardProduct(
  String image,
  String title,
  String detail,
  num price,
  String status,
  num statusValue,
  // num rating,
  // VoidCallback onEdit,
  // VoidCallback onDelete,
  {
  required Widget child,
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
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                '$apiProductUrl/$image'),
                            fit: BoxFit.contain,
                          )),
                    ),
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
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Text(
                        detail,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Utility.formatLaoKip(price),
                          style: TextStyle(
                            // fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE53E3E),
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                              color: _getStatusColor(statusValue),
                              fontSize: 12),
                        )
                      ],
                    ),
                    // StarRatingProgress(
                    //   rating: rating,
                    //   size: 14,
                    //   spacing: 0,
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(right: 0, child: child),
      ],
    ),
  );
}
