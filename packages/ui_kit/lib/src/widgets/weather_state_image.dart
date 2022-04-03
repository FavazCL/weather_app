import 'package:flutter/material.dart';

class WeatherStateImage extends StatelessWidget {
  const WeatherStateImage({Key? key, required this.state}) : super(key: key);

  final String state;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/$state.png', height: 200, package: 'ui_kit',);
  }
}
