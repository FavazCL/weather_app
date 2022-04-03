import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Class that allow create responsiveness ui
class Responsive {
  /// Constructor of the [Responsive] class
  Responsive({
    required this.width,
    required this.height,
    required this.diagonal,
    required this.isPortrait,
  });

  /// Function that return a [Responsive] class,
  factory Responsive.of(BuildContext context) {
    final data = MediaQuery.of(context);
    final size = data.size;
    final diagonal =
        math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    final isPortrait = data.orientation == Orientation.portrait;

    return Responsive(
      width: size.width,
      height: size.height,
      diagonal: diagonal,
      isPortrait: isPortrait,
    );
  }

  /// Three [double] variables to specify width, height and diagonal
  /// of given screen.
  final double width, height, diagonal;

  /// [bool] variable to specify if the current devices
  /// is portrait or landscape.
  final bool isPortrait;

  /// Given [double] percent return a width relative to the screen
  double wp(double percent) => width * percent / 100;

  /// Given [double] percent return a height relative to the screen
  double hp(double percent) => height * percent / 100;

  /// Given [double] percent return a diagonal relative to the screen
  double dp(double percent) => diagonal * percent / 100;
}
