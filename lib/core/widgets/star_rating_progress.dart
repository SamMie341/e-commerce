import 'dart:math' as math;
import 'package:flutter/material.dart';

class StarRatingProgress extends StatelessWidget {
  final num rating;
  final int max;
  final double size;
  final double spacing;
  final Color filledColor;
  final Color unfilledColor;

  const StarRatingProgress({
    super.key,
    required this.rating,
    this.max = 5,
    this.size = 24,
    this.spacing = 1,
    this.filledColor = Colors.amber,
    this.unfilledColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    final clamped =
        rating.isNaN ? 0.0 : math.max(0, math.min(rating, max.toDouble()));

    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            max,
            (i) => Padding(
              padding: EdgeInsets.only(right: i == max - 1 ? 0 : spacing),
              child: Icon(Icons.star, size: size, color: unfilledColor),
            ),
          ),
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: clamped / max,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                max,
                (i) => Padding(
                  padding: EdgeInsets.only(right: i == max - 1 ? 0 : spacing),
                  child: Icon(Icons.star, size: size, color: filledColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
