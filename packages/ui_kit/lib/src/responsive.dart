import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  final double width,
      height,
      diagonal;

  Responsive({
    required this.width,
    required this.height,
    required this.diagonal,
  });

  factory Responsive.of(BuildContext context) {
    final data = MediaQuery.of(context);
    final size = data.size;
    final diagonal =
        math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(
      width: size.width,
      height: size.height,
      diagonal: diagonal,
    );
  }

  double wp(double percent) => width * percent / 100;
  double hp(double percent) => height * percent / 100;
  double dp(double percent) => diagonal * percent / 100;
}
