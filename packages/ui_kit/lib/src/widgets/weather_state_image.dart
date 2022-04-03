import 'package:flutter/material.dart';

class WeatherStateImage extends StatelessWidget {
  const WeatherStateImage({
    Key? key,
    required this.state,
    this.height = 200,
  }) : super(key: key);

  final String state;
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
