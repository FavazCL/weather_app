import 'package:flutter/material.dart';

/// The [WeatherStateImage] class
class WeatherStateImage extends StatelessWidget {
  /// Constructor of the [WeatherStateImage] class
  const WeatherStateImage({
    Key? key,
    required this.state,
    this.height = 200,
  }) : super(key: key);

  /// State of the current Weather
  final String state;

  /// Height for the image
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$state.png',
      height: height,
      package: 'ui_kit',
    );
  }
}
